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

    # first check the user...
    user = User.find_by email_address: @authentication.email_address
    if user.nil?
      logger.debug "user #{@authentication.email_address} not found for authentication"
      @authentication.errors.add(:base, "L'adresse email ou le mot de passe est invalide")
      render action: 'new'
      return
    end

    # ...then the password
    unless user.authenticate @authentication.password
      logger.debug "incorrect password to authenticate user #{@authentication.email_address}"
      @authentication.errors.add(:base, "L'adresse email ou le mot de passe est invalide")
      render action: 'new'
      return
    end

    # store the user into the session without the password
    user.serialize
    session[:user] = user
    redirect_to user
  end


  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def authentication_params
      params.require(:authentication).permit(:email_address, :password)
    end
end
