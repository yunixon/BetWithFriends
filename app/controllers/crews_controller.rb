class CrewsController < ApplicationController
  before_action :set_crew, only: [:show, :edit, :update, :destroy, :users]

  # GET /crews
  # GET /crews.json
  def index
    @crews = Crew.all
  end

  # GET /crews/1
  # GET /crews/1.json
  def show
  end

  # GET /crews/new
  def new
    @crew = Crew.new
  end

  # GET /crews/1/edit
  def edit
  end

  # POST /crews
  # POST /crews.json
  def create
    @crew = Crew.new(crew_params)

    respond_to do |format|
      if @crew.save
        format.html { redirect_to @crew, notice: 'Crew was successfully created.' }
        format.json { render action: 'show', status: :created, location: @crew }
      else
        format.html { render action: 'new' }
        format.json { render json: @crew.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /crews/1
  # PATCH/PUT /crews/1.json
  def update
    respond_to do |format|
      if @crew.update(crew_params)
        format.html { redirect_to @crew, notice: 'Crew was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @crew.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crews/1
  # DELETE /crews/1.json
  def destroy
    @crew.destroy
    respond_to do |format|
      format.html { redirect_to crews_url }
      format.json { head :no_content }
    end
  end

  # GET /crews/1/users
  def users
    @users = User.where("crew_id = ?", @crew.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crew
      crew_id=""
      if params[:id].present?
        crew_id = params[:id]
      else
        crew_id = params[:crew_id]
      end
      @crew = Crew.find(crew_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def crew_params
      params.require(:crew).permit(:name)
    end
end
