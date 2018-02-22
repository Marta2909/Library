require "rails_helper"
# require 'database_cleaner'

# DatabaseCleaner.strategy = :truncation

describe Admin::UsersController, type: :controller do

  def http_login
    user = 'admin'
    pw = 'admin'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end

  describe 'statistics' do
    context 'when admin' do
      before do
        # DatabaseCleaner.clean
        http_login
        @user1 = User.create!(name: 'Jon')
        @user2 = User.create!(name: 'Jeff')
      end

      it 'assigns all users to @users' do
        get :statistics
        expect(assigns(:users)).to eq([@user1, @user2])
        expect((assigns(:users)).count).to eq 2
      end
    end

    context 'when not admin' do
      before do
        @user1 = User.create!(name: 'Jon')
        @user2 = User.create!(name: 'Jeff')
      end

      it 'assigns all users to @users' do
        get :statistics
        expect(assigns(:users)).to be_nil
      end
    end
  end
end
