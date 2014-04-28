class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # DON'T COMMENT ME OUT
  # protect_from_forgery with: :exception

  def current_user
    # fetches the user we've logged in as
    return nil if self.session[:session_token].nil?
    @user ||= User.find_by(session_token: self.session[:session_token])
  end

  def log_in!(user)
    # force other clients to log out by regenerating token
    user.reset_session_token!
    # log this client in
    self.session[:session_token] = user.session_token
  end

  def log_out!
    self.session[:session_token] = nil
  end

  # CSRF Stuff
  def my_csrf_token
    self.session[:_my_csrf_token] ||= SecureRandom::urlsafe_base64
  end

  before_filter :validate_csrf_token
  def validate_csrf_token
    return if self.request.method == "GET"
    return if self.session[:_my_csrf_token] == self.params[:_my_csrf_token]
    raise "CSRF ATTACK DETECTED"
  end

  helper_method :my_csrf_token
end
