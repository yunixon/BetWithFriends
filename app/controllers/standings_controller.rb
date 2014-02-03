class StandingsController < ApplicationController
  before_action :set_standings, only: [:show, :update]


  # GET /stages/1/groups/1/standings
  def show
    @group = Group.find(params[:group_id])
  end

  # PATCH/PUT /stages/1/groups/1/standings
  def update
    @standings.each do |standing|
      
      standing.played = 0
      standing.won = 0
      standing.draw = 0
      standing.lost = 0
      standing.goals_against = 0
      standing.goals_for = 0
      standing.points = 0

      matches = Match.where("(team_a_id = ? or team_b_id = ?) and results.played = 't'", standing.team_id, standing.team_id)

      matches.each do |match|

        standing.played += 1

        # team_a
        if match.team_a_id == standing.team_id
          standing.goals_for += match.result.score_team_a
          standing.goals_against += match.result.score_team_b
          if match.result.score_team_a > match.result.score_team_b
            standing.won += 1
            standing.points += 3
          elsif match.result.score_team_a == match.result.score_team_b
            standing.draw += 1
            standing.points += 1
          else
            standing.lost += 1
          end
        # team_b
        else
          standing.goals_for += match.result.score_team_b
          standing.goals_against += match.result.score_team_a
          if match.result.score_team_a > match.result.score_team_b
            standing.lost += 1
          elsif match.result.score_team_a == match.result.score_team_b
            standing.draw += 1
            standing.points += 1
          else
            standing.won += 1
            standing.points += 3
          end
        end

      end

      if standing.save
        logger.debug "standing saved #{standing.inspect}"
      else
        logger.error "error saving standing #{standing.inspect}"
      end

    end

    respond_to do |format|
      format.html { redirect_to stage_group_standings_path(params[:stage_id], params[:group_id]), notice: 'Standings were successfully updated.'}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_standings
      @standings = Standing.where("group_id = ?", params[:group_id])
    end
end
