require 'rails_helper'

describe BooksController do
  let!(:first_book) { Book.create(author: 'Jan Kowalski', title: "tytuł", publisher: "wydawca", description: "opis", year: 2017, count: 20, borrowed_count: 0) }
  let!(:user) { User.create(provider: "google", uid: "1234")}

  describe "GET index" do
    it "should show all books with pages" do
      get :index
      expect(response).to be_success
      expect(assigns(:books)).not_to be_nil
    end
  end

  describe "GET show" do
    it "should be successful" do
      get :show, params: {id: Book.first.id }
      expect(response).to be_success
      expect(assigns(:book)).not_to be_nil
      expect(response).to render_template :show
    end
  end

  describe "orderbook" do
    it "should order a book (make a new order) and increase book's borrowed_count by 1" do
      session[:user_id] = user.id

      before = first_book.borrowed_count

      expect { get :orderbook, params: {id: first_book.id } }.to change(Order, :count).by(1)
      expect(assigns(:book)).to eq first_book

      assigns(:book).update_attribute(:borrowed_count, first_book.borrowed_count+1)
      after = assigns(:book).borrowed_count
      
      expect(after - before).to eq 1
      expect(assigns(:book).save).to be true
      expect(response).to redirect_to orders_path
    end
  end

end
