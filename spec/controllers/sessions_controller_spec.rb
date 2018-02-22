require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  before do
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
  end

  describe "POST #create" do
    it "creates a user" do
      expect { post :create }.to change{ User.count }.by(1)
    end
    it "creates a session" do
      expect(session[:user_id]).to be_nil
      post :create
      expect(session[:user_id]).not_to be_nil
    end
    it "redirects to the root" do
      post :create
      expect(response).to redirect_to(root_path)
    end
  end

  describe "#destroy" do
    before do
      post :create
    end

    it "should clear the session" do
      expect(session[:user_id]).not_to be_nil
      delete :destroy
      expect(session[:user_id]).to be_nil
    end

    it "should redirect to the home page" do
      delete :destroy
      expect(response).to redirect_to(root_path)
    end
  end

end
