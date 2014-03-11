class StandingsController < ApplicationController
  before_action :set_standings, only: [:show, :update]


  # GET /stages/1/groups/1/standings
  def show
    @group = Group.find(params[:group_id])
  end

  # PATCH/PUT /stages/1/groups/1/standings
  def update
    @standings.each do |standing|
      standing.compute_and_update
    end

    redirect_to stage_group_standings_path(params[:stage_id], params[:group_id])

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_standings
      @standings = Standing.where("group_id = ?", params[:group_id]).order(points: :desc).order("teams.name asc")
    end
end
