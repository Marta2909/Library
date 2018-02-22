require 'rails_helper'

RSpec.describe 'orders/index', type: :view do

  before(:each) do
    first_book = Book.create!(author: 'Jan Kowalski', title: "tytuł 1", publisher: "wydawca", description: "opis", year: 2017, count: 20)
    first_book.borrowed_count = 1
    first_book.save
    user = User.create!
    session[:user_id] = user.id
    order = Order.create!(user_id: user.id, book_id: first_book.id, book_title: first_book.title, book_author: first_book.author, is_returned: false)
    @orders = [order]
  end

  it 'shows orders list' do
    allow(view).to receive_messages(:paginate => nil)
    render
    expect(rendered).to match /Days to deadline/
  end
end
