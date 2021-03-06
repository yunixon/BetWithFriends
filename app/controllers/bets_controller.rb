class BetsController < ApplicationController
	before_action :set_user, only: [:new, :create, :edit, :update]
  before_action :set_bet, only: [:show, :edit, :update]


  # GET /users/:user_id/bets
  def index
    @user = User.includes(bet: [:result, match:[:group, :team_a, :team_b]]).references(:bet).find(params[:user_id])
    logger.debug "List #{@user.bet.length} bet(s) for user ##{params[:user_id]}"
  end

  # GET /users/:user_id/bets/:id
  def show
    logger.debug "show bet #{@bet.inspect}"
  end


  # GET /users/:user_id/bets/new
  def new
  	@bet = Bet.new
  	@bet.build_result
  end

  # GET /users/:user_id/bets/:id/edit
  def edit
  end

  # POST /users/:user_id/bets
  def create

		@bet = Bet.new(bet_params)
		@bet.user_id = params[:user_id]

		respond_to do |format|
      if @bet.save
        logger.debug "bet created #{@bet.inspect}"
        format.html { redirect_to user_bet_path(@bet.user_id, @bet.id), notice: 'Bet was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
	end

  # PUT/PATCH /users/:user_id/bets/:id
  def update
    respond_to do |format|
      if @bet.update(bet_params_for_update)
        logger.debug "bet updated #{@bet.inspect}"
        format.html { redirect_to user_bet_path(@bet.user_id, @bet.id), notice: 'Bet was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bet
      @bet = Bet.where("user_id = ? and bets.id = ?", params[:user_id], params[:id]).take!
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bet_params
      params.require(:bet).permit(:match_id, result_attributes: [:score_team_a, :score_team_b])
    end
    # Update does not allow the match to be changed
    def bet_params_for_update
      params.require(:bet).permit(result_attributes: [:score_team_a, :score_team_b])
    end

end
