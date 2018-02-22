require 'rails_helper'

RSpec.describe 'admin/users/statistics', type: :view do

  before do
    @book = Book.create!(author: 'Author1', title: "Title1", publisher: "Publisher1", description: "Description1", year: 2017, count: 20, borrowed_count: 2)
    @users = [User.create!(name: 'Jon')]
    Order.create!(user_id: @users.first.id, book_id: @book.id, book_title: @book.title, book_author: @book.author, is_returned: false)
    Order.create!(user_id: @users.first.id, book_id: @book.id, book_title: @book.title, book_author: @book.author, is_returned: true)
    render
  end

  it 'displays all users list with the number of books they borrowed or have borrowed now' do
    expect(rendered).to match /Users statistics/
    expect(rendered).to match /Jon/
    expect(rendered).to match /2/
    expect(rendered).to match /1/
  end
end
