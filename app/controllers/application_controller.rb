class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  before_filter :get_authentication


	protected

  def get_authentication
    @authentication = Authentication.find_by token: cookies[:bwf_token]
    logger.debug "authentication ==> #{@authentication.inspect}"
  end


	# check that the user is logged in
  def authentication_required

  	# if not found, let's redirect to the login page
  	if @authentication.nil? || @authentication.updated_at < 30.minutes.ago
  		render :file => "public/401.html", :status => :unauthorized, :layout => false
  		return
  	end

  	# check the ip address as well as the user-agent
  	user_agent = Digest::SHA1.base64digest request.user_agent
  	if @authentication.user_agent != user_agent || @authentication.ip != request.remote_ip
  		@authentication.destroy
  		render :file => "public/401.html", :status => :unauthorized, :layout => false
  		return
  	end

  	# should the authentication be updated ? 
  	if @authentication.updated_at < 5.minutes.ago
  		@authentication = save_authentication @authentication
  		logger.debug "authentication ##{@authentication.id} updateded"
  	end

  end


  # create a new authentication, save it and update the cookie or return nil if a problem occured
  def create_authentication user_id
		# reuse the already existing authentication
    new_authentication = Authentication.find_by user_id: user_id
    if new_authentication.nil?
      new_authentication = Authentication.new
     	new_authentication.user_id = user_id
    end
    return save_authentication new_authentication
  end



  private

  # save or update the current authentication and set the authentication token cookie
  def save_authentication current_authentication
  	current_authentication.email_address = "email"
  	current_authentication.password = "password"
    current_authentication.ip = request.remote_ip
    current_authentication.user_agent = Digest::SHA1.base64digest request.user_agent
    current_authentication.token = SecureRandom.base64 45
    if current_authentication.save
    	cookies[:bwf_token] = { 
        :value => current_authentication.token,
        :expires => 1.hour.from_now,
        #:domain => 'bwf.com',
        :httponly => true
      }
      return current_authentication
    else
    	return nil
    end
  end

end
