require "rails_helper"

RSpec.describe ApplicationHelper, :type => :helper do
  describe "count_debt" do
    context "when deadline was more than 5 days" do
      before do
        @first_book = Book.create!(author: 'Author1', title: "Title1", publisher: "Publisher1", description: "Description1", year: 2017, count: 20)
        @user = User.create!
        @order = Order.create!(user_id: @user.id, book_id: @first_book.id, book_title: @first_book.title, book_author: @first_book.author, is_returned: false, deadline: Date.today-10.days)
      end
      it 'returns 50 dollars debt' do
        expect(helper.count_debt(@order)).to eq(50.0)
      end
    end
    context "when deadline was less than 5 days" do
      before do
        @first_book = Book.create!(author: 'Author1', title: "Title1", publisher: "Publisher1", description: "Description1", year: 2017, count: 20)
        @user = User.create!
        @order = Order.create!(user_id: @user.id, book_id: @first_book.id, book_title: @first_book.title, book_author: @first_book.author, is_returned: false, deadline: Date.today-2.days)
      end
      it 'returns 10 dollars debt' do
        expect(helper.count_debt(@order)).to eq(10.0)
      end
    end
    context "when deadline was less than 5 days" do
      before do
        @first_book = Book.create!(author: 'Author1', title: "Title1", publisher: "Publisher1", description: "Description1", year: 2017, count: 20)
        @user = User.create!
        @order = Order.create!(user_id: @user.id, book_id: @first_book.id, book_title: @first_book.title, book_author: @first_book.author, is_returned: false, deadline: Date.today+2.days)
      end
      it 'returns 0 dollars debt' do
        expect(helper.count_debt(@order)).to eq(0.0)
      end
    end
  end
end
