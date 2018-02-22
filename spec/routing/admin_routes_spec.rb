require 'rails_helper'

RSpec.describe 'routes for admin', type: :routing do
  it 'routes /admin/user_statistics to admin/users controller and statistics action' do
    expect(get('/admin/user_statistics')).to route_to(controller: 'admin/users', action: 'statistics')
  end

  it 'routes /admin/books to admin/books controller and index action' do
    expect(get('/admin/books')).to route_to(controller: 'admin/books', action: 'index')
  end

  it 'routes POST /admin/books to admin/books controller and create action' do
    expect(post('/admin/books')).to route_to(controller: 'admin/books', action: 'create')
  end

  it 'routes /admin/books/new to admin/books controller and new action' do
    expect(get('/admin/books/new')).to route_to(controller: 'admin/books', action: 'new')
  end

  it 'routes /admin/books/1/edit to admin/books controller and edit action' do
    expect(get('/admin/books/1/edit')).to route_to(controller: 'admin/books', action: 'edit', id: '1')
  end

  it 'routes /admin/books/1 to admin/books controller and show action' do
    expect(get('/admin/books/1')).to route_to(controller: 'admin/books', action: 'show', id: '1')
  end

  it 'routes PUT /admin/books/1 to admin/books controller and update action' do
    expect(put('/admin/books/1')).to route_to(controller: 'admin/books', action: 'update', id: '1')
  end

  it 'routes DELETE /admin/books/1 to admin/books controller and destroy action' do
    expect(delete('/admin/books/1')).to route_to(controller: 'admin/books', action: 'destroy', id: '1')
  end
end
