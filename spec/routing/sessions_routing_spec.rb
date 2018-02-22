require 'rails_helper'

RSpec.describe 'routes for sessions', type: :routing do
  it 'routes /auth/google/callback to sessions controller and create action' do
    expect(get('/auth/google/callback')).to route_to(controller: 'sessions', action: 'create', provider: 'google')
  end
  it 'routes /signout to sessions controller and destroy action' do
    expect(get('/signout')).to route_to(controller: 'sessions', action: 'destroy')
  end
  it 'routes POST /sessions to sessions controller and create action' do
    expect(post('/sessions')).to route_to(controller: 'sessions', action: 'create')
  end
end
