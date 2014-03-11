class AdministrationController < ApplicationController

  before_action :set_match, only: [:edit_match_result, :update_match_result]

  def home
  end

  #GET matches/:id/result/edit
  def edit_match_result
    if @match.result.nil?
      @match.build_result
    end
  end

  # PUT matches/:id/result/edit
  def update_match_result

    # should the result be created
    if @match.result.nil?
      @match.build_result(result_params)
      result_updated = @match.result.save
    # or updated
    else
      result_updated = @match.result.update(result_params)
    end

    if result_updated
      redirect_to admin_home_path, notice: 'Result was successfully created.'
    else
      render action: 'edit_match_result'
    end

  end

  def update_standings
  end

  def edit_ranking
  end

  def update_ranking
  end

  private

    def set_match
      @match = Match.find(params[:id])
    end

    def result_params
      params.require(:result).permit(:score_team_a, :score_team_b, :played)
    end


end
