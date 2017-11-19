require 'rails_helper'

describe SessionsController do

  before do
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end

  describe "POST create" do
    it "should create a user" do
      expect { post :create }.to change(User, :count).by(1)
    end

    it "should create a session" do
      expect(session[:user_id]).to be_nil
      post :create
      expect(session[:user_id]).not_to be_nil
    end

    it "should emit a flash message" do
      post :create
      expect(flash[:notice]).to eq "Zalogowano"
    end

    it "should redirect user to the root path" do
      post :create
      expect(response).to redirect_to root_path
    end
  end

  describe "DELETE destroy" do
    before do
      post :create
    end

    it "should clear the session" do
      expect(session[:user_id]).not_to be_nil
      delete :destroy
      expect(session[:user_id]).to be_nil
    end

    it "should emit a flash message" do
      delete :destroy
      expect(flash[:notice]).to eq "Wylogowano"
    end

    it "should redirect to the root path" do
      delete :destroy
      expect(response).to redirect_to root_path
    end
  end

end
