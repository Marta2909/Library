class Admin::UsersController < ApplicationController
  before_action :authenticate

  def statistics
    @users = User.all
  end

  private

  def authenticate
    authenticate_or_request_with_http_basic 'Enter password' do |name, password|
      name == 'admin' && password == 'admin'
    end
    session[:admin] = 'admin'
  end

end
