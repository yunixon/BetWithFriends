class UsersController < ApplicationController
  before_action :authenticated_user_required, only: [:show, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_owner, only: [:show, :edit, :update]


  # GET /users/1
  # GET /users/1.json
  def show
    @matches = Match.all
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user] = @user.serialize
      redirect_to @user
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email_address, :password, :password_confirmation, :crew_id)
    end

    # check that the accessed user is the authenticated one
    def check_owner
      if @user.id != @authenticated_user.id
        render :file => "public/403.html", :status => :forbidden, :layout => false
        return
      end
    end

end
