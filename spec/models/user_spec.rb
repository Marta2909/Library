require 'rails_helper'

auth_hash = OmniAuth::AuthHash.new({
  :provider => 'google',
  :uid => '1234',
  :info => {
    :email => "user@example.com",
    :name => "Justin Bieber"
  }
})


describe User, "#from_omniauth" do
  it "retrieves an existing user" do
    user = User.new(
      :provider => "google",
      :uid => 1234,
      :name => "Justin Bieber",
      :oauth_token = auth.credentials.token
    )
    user.save
    omniauth_user = User.from_omniauth(auth_hash)
    expect(user).to eq(omniauth_user)
  end
end
