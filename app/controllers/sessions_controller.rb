class SessionsController < ApplicationController #a controller for Google auth
  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = user.id
    flash[:notice] = "Zalogowano"
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Wylogowano"
    redirect_to root_path
  end
end
