require 'rails_helper'

describe OrdersController do

  before(:each) do
    @first_book = Book.create!(author: 'Author1', title: "Title1", publisher: "Publisher1", description: "Description1", year: 2017, count: 20)
    @first_book.borrowed_count = 1
    @first_book.save
    @user = User.create!
    session[:user_id] = @user.id
    @order = Order.create!(user_id: @user.id, book_id: @first_book.id, book_title: @first_book.title, book_author: @first_book.author, is_returned: false)
  end

  describe "GET index" do
    it "shows current user's ordered books" do
      get :index
      expect(response).to be_success
      expect(assigns(:orders)).not_to be_empty
      assigns(:orders).each do |o|
        expect(o.user_id).to eq(session[:user_id])
      end
    end

    it "should show current user's ordered books in proper order (the newest order the first)" do
      get :index
      expect(assigns(:orders).first.created_at).to be >= assigns(:orders).last.created_at
    end
  end

  describe "GET returnbook" do
    it "should find the proper book" do
      get :returnbook, params: {id: @order.id}
      expect(assigns(:order).book_title).to eq @first_book.title
    end

    it "should return the book (change the is_returned attribute to true)" do
      get :returnbook, params: {id: @order.id}
      expect(assigns(:order).is_returned).to be true
    end

    it "should decrease borrowed_count of the book by 1" do
      get :returnbook, params: {id: @order.id}
      expect { get :returnbook, params: {id: @order.id} }.to change{Book.where("title = ?", assigns(:order).book_title).first.borrowed_count}.by(-1)
    end

    it "should redirect to root path" do
      get :returnbook, params: {id: @order.id}
      expect(response).to redirect_to root_path
    end
  end

end
