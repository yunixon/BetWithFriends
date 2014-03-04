class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception



  before_filter :get_authenticated_user


	protected

  # put the authenticated user in the request if there's any
  def get_authenticated_user
    @authenticated_user = session[:user]
    logger.debug "authenticated user ==> #{@authenticated_user.inspect}"
  end


  def authenticated_user_required
    if @authenticated_user.nil?
      render :file => "public/401.html", :status => :unauthorized, :layout => false
      return
    end
  end

end
