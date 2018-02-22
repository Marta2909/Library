class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Google auth
  helper_method :current_user

  def log_out_admin
    session[:admin] = nil
    redirect_to root_path
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
