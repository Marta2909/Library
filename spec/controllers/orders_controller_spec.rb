require 'rails_helper'

describe OrdersController do
  let!(:first_book) { Book.create(author: 'Jan Kowalski', title: "tytuł", publisher: "wydawca", description: "opis", year: 2017, count: 20, borrowed_count: 0) }
  let!(:user) { User.create(provider: "google", uid: "1234")}

  #describe "GET new" do
  #  it "should redirect to create action" do
  #    get :new
  #    expect(response).to redirect_to action: :create
  #  end
  #end

  #describe "POST create" do
  #  it "should create an order if a book is available to borrow" do
  #    session[:user_id] = user.id
  #    post :create, params: {id: first_book.id}
  #    expect(assigns(:book)).to eq first_book
  #    expect(assigns(:order)).not_to be_nil
  #    expect(assigns(:book).count - assigns(:book).borrowed_count).to be > 0
  #    expect(assigns(:order).save).to be false
  #    expect(flash[:notice]).to eq "Spróbuj jeszcze raz"
  #    expect(response).to redirect_to root_path
      #expect(assigns(:book).borrowed_count).to be >= 1
  #  end
  #end

  describe "GET index" do
    it "should show current user's ordered books" do
      session[:user_id] = user.id
      Order.create!(user_id: user.id, book_id:first_book.id)
      get :index
      expect(response).to be_success
      expect(assigns(:orders)).not_to be_empty
      expect(assigns(:orders).last.user_id).to eq user.id
    #  expect(assigns(:orders)).to include(user.id}
      expect(assigns(:orders).first.created_at).to be >= assigns(:orders).last(created_at)
      #Order.stub(:where).and_return([mock_model(Order, user_id: user.id)])
    end
      #@orders = Order.where(user_id: current_user.id).order(created_at: :DESC).page(params[:page]).per(10)
  end

  describe "GET returnbook" do

  end
end
