class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :edit, :update, :destroy, :result, :edit_result, :update_result]

  # GET /matches
  def index
    @group = Group.find(params[:group_id])
    @matches = Match.where("group_id = ?", @group.id)
  end

  def show
  end

  def new
    @match = Match.new
  end

  def edit
  end

  # POST /matches
  # POST /matches.json
  def create
    @match = Match.new(match_params)
    @match.group_id = params[:group_id]

    respond_to do |format|
      if @match.save
        format.html { redirect_to stage_group_match_path(params[:stage_id], params[:group_id], @match.id), notice: 'Match was successfully created.' }
        format.json { render action: 'show', status: :created, location: @match }
      else
        format.html { render action: 'new' }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /matches/1
  # PATCH/PUT /matches/1.json
  def update
    respond_to do |format|
      if @match.update(match_params)
        format.html { redirect_to stage_group_match_path(params[:stage_id], params[:group_id], @match.id), notice: 'Match was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE matches/1
  def destroy
  end

  # GET matches/1/result
  def result
  end

  # GET matches/1/result/edit
  def edit_result
    if @match.result.nil?
      @match.build_result
    end
  end

  # PUT/PATCH matches/1/result
  def update_result

    # should the result be created
    if @match.result.nil?
      @match.build_result(result_params)
      result_updated = @match.result.save
    # or updated
    else
      result_updated = @match.result.update(result_params)
    end

    if result_updated
      redirect_to result_stage_group_match_path(params[:stage_id], params[:group_id], params[:id]), notice: 'Result was successfully created.'
    else
      render action: 'edit_result'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.where("group_id = ? and matches.id = ?", params[:group_id], params[:id]).take!
    end
    def set_result
      #@result = Result.where("resultable_type = ? and resultable_id = ?", Result::TYPE_MATCH, params[:id]).take
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def match_params
      params.require(:match).permit(:date, :team_a_id, :team_b_id)
    end
    def result_params
      params.require(:result).permit(:score_team_a, :score_team_b, :played)
    end
end

