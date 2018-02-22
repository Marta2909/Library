require "rails_helper"

describe ApplicationController, type: :controller do

  describe 'log_out_admin' do
    before(:each) do
      session[:admin] == 'admin'
    end

    it 'deletes a session' do
      get :log_out_admin
      expect(session[:Admin]).to be_nil
    end

    it 'redirects to root_path' do
      get :log_out_admin
      expect(response).to redirect_to root_path
    end
  end
end
