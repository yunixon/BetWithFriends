class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy, :teams, :matches, :standings]

  # GET /stages/{stage_id}/groups
  # GET /stages/{stage_id}/groups.json
  def index
    @groups = Group.where(stage_id: params[:stage_id])
    @stage = Stage.find(params[:stage_id])
  end

  # GET /stages/{stage_id}/groups/1
  # GET /stages/{stage_id}/groups/1.json
  def show
  end

  # GET /stages/{stage_id}/groups/new
  def new
    @group = Group.new
    @group.stage_id = params[:stage_id]
  end

  # GET /stages/{stage_id}/groups/1/edit
  def edit
  end

  # POST /stages/{stage_id}/groups
  # POST /stages/{stage_id}/groups.json
  def create
    @group = Group.new(group_params)
    @group.stage_id = params[:stage_id]

    respond_to do |format|
      if @group.save
        format.html { redirect_to stage_path(params[:stage_id]), notice: 'Group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @group }
      else
        format.html { render action: 'new' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stages/{stage_id}/groups/1
  # PATCH/PUT /stages/{stage_id}/groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to stage_path(params[:stage_id]), notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to stage_path(params[:stage_id]) }
      format.json { head :no_content }
    end
  end

  # GET /stages/{stage_id}/groups/1/matches
  def matches
     @matches = Match.where("group_id = ?", @group.id)
  end

  # GET /stages/{stage_id}/groups/1/teams
  def teams
    @teams = Team.joins("INNER JOIN matches AS matches ON matches.team_a_id=teams.id OR matches.team_b_id=teams.id").where("matches.group_id = ?", @group.id).distinct
  end

  # GET /stages/{stage_id}/groups/1/standings
  def standings
    @standings = Standing.where(group_id: params[:group_id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      if (params[:group_id].present?)
        group_id = params[:group_id]
      else 
        group_id = params[:id]
      end
      @group = Group.where("stage_id = ? and id = ?", params[:stage_id], group_id).take!
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name)
    end
end
