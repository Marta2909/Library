require 'rails_helper'

RSpec.describe 'admin/books/show', type: :view do

  before(:each) do
    @book = Book.create!(author: 'Author1', title: "Title1", publisher: "Publisher1", description: "Description1", year: 2017, count: 20, borrowed_count: 2)
    @user = User.create!
    @order = Order.create!(user_id: @user.id, book_id: @book.id, book_title: @book.title, book_author: @book.author, is_returned: false)
    @not_returned_books = @book.orders
    render
  end

  it 'renders partial' do
    expect(rendered).to match /Year of edition/
  end

  it 'renders table with info who has not returned book' do
    expect(rendered).to match /Borrow date/
  end
end
