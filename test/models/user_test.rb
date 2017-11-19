require 'test_helper'

class UserTest < ActiveSupport::TestCase

  auth_hash = OmniAuth::AuthHash.new({
    :provider => 'google',
    :uid => '1234',
    :info => {
      :name => "Justin"
    },
    :credentials => {
      :token => "password"
    }
  })

  test "should can take user from omniauth" do
    user = User.new(
      :provider => "google",
      :uid => 1234,
    )
    user.save
    omniauth_user = User.from_omniauth(auth_hash)

    assert_equal(user, omniauth_user)
  end

  test "should create a new user if one doesn't already exist" do
    count_before = User.count
    omniauth_user = User.from_omniauth(auth_hash)
    count_after = User.count
    assert_equal(count_after - count_before, 1)
  end

end
