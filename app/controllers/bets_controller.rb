class BetsController < ApplicationController
	before_action :set_player, only: [:index, :new, :create]

  # GET /players/:player_id/bets
  def index
    @bets = Bet.where("player_id = ?", params[:player_id])
  end

  # GET /players/:player_id/bets/:id
  def show
  	@bet = Bet.where("player_id = ? and bets.id = ?", params[:player_id], params[:id]).take!
  end


  # GET /players/:player_id/bets/new
  def new
  	@bet = Bet.new
  	@bet.build_result
  end

  # POST /players/:player_id/bets
  def create

		logger.debug "score_team_a ==> #{params[:bet]}"


		@bet = Bet.new(bet_params)

		@bet.player_id = params[:player_id]

		logger.debug "bet to create ==> #{@bet.inspect}"
		logger.debug "result to create ==> #{@bet.result.inspect}"

		respond_to do |format|
      if @bet.save
        format.html { redirect_to player_bet_path(@bet.player_id, @bet.id), notice: 'Bet was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
	end


  private
    # Use callbacks to share common setup or constraints between actions.
    #def set_bet
    #  if (params[:team_id].present?)
    #    @bet = Team.find(params[:team_id])
    #  else 
    #    @bet = Team.find(params[:id])
    #  end
    #end

    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:player_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bet_params
      params.require(:bet).permit(:match_id, result_attributes: [:score_team_a, :score_team_b])
    end

end
