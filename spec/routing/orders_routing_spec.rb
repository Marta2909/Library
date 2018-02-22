require 'rails_helper'

RSpec.describe 'routes for orders', type: :routing do
  it 'routes /returnbook/1 to orders controller and returnbook action' do
    expect(get('/returnbook/1')).to route_to(controller: 'orders', action: 'returnbook', id: '1')
  end

  it 'routes /orders to orders controller and index action' do
    expect(get('/orders')).to route_to('orders#index')
  end

  it 'routes POST /orders to orders controller and create action' do
    expect(post('/orders')).to route_to('orders#create')
  end
end
