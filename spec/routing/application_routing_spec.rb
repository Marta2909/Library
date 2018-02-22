require 'rails_helper'

RSpec.describe 'routes for application', type: :routing do
  it 'routes /log_out_admin to application controller and log_out_admin action' do
    expect(get('/log_out_admin')).to route_to('application#log_out_admin')
  end
end
