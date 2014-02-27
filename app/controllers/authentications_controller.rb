class AuthenticationsController < ApplicationController


  # GET /authentications/new
  def new
    @authentication = Authentication.new
  end


  # POST /authentications
  def create

    @authentication = Authentication.new(authentication_params)

    # if there are already an error within the authentication, let's not work for nothing
    unless @authentication.valid?
      logger.debug "authentication form is invalid, let's stop the authentication process"
      render action: 'new'
      return
    end

    # first check the player...
    player = Player.find_by email_address: @authentication.email_address
    if player.nil?
      logger.debug "player #{@authentication.email_address} not found for authentication"
      @authentication.errors.add(:base, "email address or password incorect")
      render action: 'new'
      return
    end


    # ...then the password
    actual_password = Digest::SHA1.base64digest @authentication.password + "|+|" + @authentication.email_address
    if actual_password != player.password
      logger.debug "incorrect password to authenticate user #{@authentication.email_address}"
      @authentication.errors.add(:base, "email address or password incorect")
      render action: 'new'
      return
    end

    # create the authentication
    @authentication = create_authentication player.id
    if @authentication.nil?
      logger.debug "error saving authentication "
      render action: 'new'
      return
    else
      redirect_to root_path
      return
    end
  end


  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def authentication_params
      params.require(:authentication).permit(:email_address, :password)
    end
end