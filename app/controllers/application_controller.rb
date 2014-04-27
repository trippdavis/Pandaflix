class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # DON'T COMMENT ME OUT
  # protect_from_forgery with: :exception

  def current_user
    # fetches the user we've logged in as
    return nil if self.session[:user_id].nil?
    User.find(self.session[:user_id])
  end

  def log_in!(user)
    self.session[:user_id] = user.id
  end

  def log_out!
    self.session[:user_id] = nil
  end
end
