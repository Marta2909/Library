require 'rails_helper'

RSpec.describe Order, type: :model do

  context 'user' do
    let(:response) { User.new }
    let(:response2) { Order.new }

    it 'belongs to user' do
      expect( response.orders.new ).to be_a_new Order
      expect{ response2.users }.to raise_error(NoMethodError)
      expect{ response2.user }.not_to raise_error
    end
  end

  context 'book' do
    let(:response) { Book.new }
    let(:response2) { Order.new }

    it 'belongs to user' do
      expect( response.orders.new ).to be_a_new Order
      expect{ response2.books }.to raise_error(NoMethodError)
      expect{ response2.book }.not_to raise_error
    end
  end

  context 'scope' do
    it 'finds not returner orders' do
      book = Book.create!(author:'author1', title: 'title1', description: 'description1', year:2018, publisher: 'publisher1')
      user = User.create!
      o1 = Order.create!(book_id: book.id, user_id: user.id, book_title: 'title1', book_author: 'author1', is_returned: false, deadline: Time.now+7.days, debt: 0)
      o2 = Order.create!(book_id: book.id, user_id: user.id, book_title: 'title2', book_author: 'author2', is_returned: true, deadline: Time.now+7.days, debt: 0)

      expect(Order.not_returned_user_books).to eq([o1])
    end
  end
end
