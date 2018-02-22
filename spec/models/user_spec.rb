require 'rails_helper'

context 'when a Book object is created' do
  let(:response) { User.new }

  it 'can have many orders' do
    expect( response.orders.new ).to be_a_new Order
  end
end

context 'from_omniauth' do
  it "retrieves an existing user" do
    auth_hash = OmniAuth::AuthHash.new({
      :provider => 'google_oauth2',
      :uid => '12345',
      :info => {
        :name => 'username',
      },
      :credentials => {
        :token => "TOKEN",
        :expires_at => 1496120719,
      }
    })
    omniauth_user = User.from_omniauth(auth_hash)
    expect(omniauth_user.name).to eq('username')
  end

  it "creates a new user if one doesn't already exist" do
    expect{ User.from_omniauth(OmniAuth::AuthHash.new({
                  :provider => 'google_oauth2',
                  :uid => '12345',
                  :info => {
                    :name => 'username',
                  },
                  :credentials => {
                    :token => "TOKEN",
                    :expires_at => 1496120719,
                  }
                  })) }.to change { User.count }.by(1)
  end
end
