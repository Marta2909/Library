require 'rails_helper'

auth_hash = OmniAuth::AuthHash.new({
  :provider => 'google',
  :uid => '1234',
  :info => {
    :name => "Justin Bieber"
  },
  :credentials => {
    :token => "password"
  }
})

describe User, "#from_omniauth" do
    it "should has many orders" do
      should have_many(:orders)
    end

    it "should retrieve an existing user" do
        user = User.new(
            :provider => "google",
            :uid => 1234
            )
        user.save
        omniauth_user = User.from_omniauth(auth_hash)

        expect(user).to eq(omniauth_user)
  end

  it "should create a new user if one doesn't already exist" do
    before = User.count
    omniauth_user = User.from_omniauth(auth_hash)
    after = User.count
    expect(after-before).to eq(1)
  end
end
