require 'rails_helper'

RSpec.describe 'routes for books', type: :routing do
  it 'routes the root to books controller and index action' do
    expect(get('/')).to route_to('books#index')
  end

  it 'routes /books to books controller and index action' do
    expect(get('/books')).to route_to('books#index')
  end

  it 'routes /books/1 to books controller and show action' do
    expect(get('/books/1')).to route_to(controller: 'books', action: 'show', id: '1')
  end

  it 'routes /search_results to books controller and search_results action' do
    expect(get('/search_results')).to route_to('books#search_results')
  end

  it 'routes /orderbook/1 to books controller and orderbook action' do
    expect(get('/orderbook/1')).to route_to(controller: 'books', action: 'orderbook', id: '1')
  end
end
