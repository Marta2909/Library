require "rails_helper"

describe Admin::BooksController do

  it "should authenticate admin before each action" do
    should use_before_action(:authenticate)
  end

  def http_login
    user = 'admin'
    pw = 'admin'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end

  before(:each) do
    http_login
  end

  describe "GET index" do
    it "should be successful" do
      get :index
      expect(response).to be_success
      expect(assigns(:books)).not_to be_nil
    end
  end

  describe "GET new" do
    it "should be successful" do
      get :new
      expect(response).to be_success
      expect(assigns(:book).title).to be_nil
      expect(assigns(:book).author).to be_nil
      expect(assigns(:book).description).to be_nil
      expect(assigns(:book).publisher).to be_nil
      expect(assigns(:book).year).to be_nil
      expect(assigns(:book).count).to be_nil
      expect(assigns(:book).borrowed_count).to eq 0
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    it "should be successful if book has all attributes" do
      expect { post :create, params: {book: { author: 'Jan Kowalski', title: "tytuł", publisher: "wydawca", description: "opis", year: 2017, count: 20 } } }.to change(Book, :count).by(1)
      expect(assigns(:book).title).to eq "tytuł"
      expect(assigns(:book).author).to eq "Jan Kowalski"
      expect(assigns(:book).borrowed_count).to eq 0
      expect(assigns(:book).save).to be true
      expect(flash[:notice]).to eq "Książka dodana"
      expect(response).to redirect_to admin_books_path
    end
    it "should not be successful if book has not all attributes" do
      expect { post :create, params: {book: { title: "tytuł", publisher: "wydawca", description: "opis", year: 2017, count: 20 } } }.not_to change(Book, :count)
      expect(assigns(:book).save).to be false
      expect(flash[:notice]).to eq "Spróbuj jeszcze raz"
      expect(response).to render_template :new
    end
  end

  describe "GET edit" do
    it "should be successful" do
      get :edit, params: {id: Book.first.id}
      expect(response).to be_success
      expect(response).to render_template :edit
    end
  end

  describe "PUT update" do
    let(:attr) { { title: 'new title' } }

    it "should be successful if book has all attributes" do
      put :update, params: {id: Book.first.id, book: attr}
      expect(assigns(:book).save).to be true
      expect(flash[:notice]).to eq "Zaktualizowano dane o książce"
      expect(Book.first.title).to eql attr[:title]
      expect(response).to redirect_to admin_books_path
    end

    it "should not be successful if book has not all attributes" do
      put :update, params: {id: Book.first.id, book: {title: nil}}
      expect(assigns(:book).save).to be false
      expect(flash[:notice]).to eq "Spróbuj jeszcze raz"
      expect(Book.first.title).not_to eql attr[:title]
      expect(response).to render_template :edit
    end
  end

  describe "GET show" do
    it "should be successful" do
      get :show, params: {id: Book.first.id}
      expect(response).to be_success
      expect(response).to render_template :show
    end
  end

  describe "DELETE destroy" do
    it "should be successful" do
      expect { delete :destroy, params: {id: Book.last.id} }.to change(Book, :count).by(-1)
      expect(flash[:notice]).to eq "Książka usunięta z biblioteczki. Nie można już wypożyczyć żadnej sztuki"
      expect(response).to redirect_to admin_books_path
    end
    it "should not be successful if the book doesn't exist" do
      expect { delete :destroy, params: {id: Book.last.id+1} }.to raise_error(ActiveRecord::RecordNotFound)
      #expect(flash[:notice]).to eq "Spróbuj jeszcze raz"
      #expect(response).to render_template :index
    end
  end

  describe "books_params" do
    it "should permit the params on create" do
      params = {
        book: {
          author: "Jan Kowalski",
          title: "tytuł",
          publisher: "wydawca",
          description: "opis",
          year: 2017,
          count: 20,
          borrowed_count: 4
        }
      }
      should permit(:author, :title, :publisher, :description, :year, :count).
        for(:create, params: params).
        on(:book)
    end

    it "should permit the params on update" do
      params = {
        id: Book.first.id,
        book: {
          author: "Jan Kowalski",
          title: "tytuł",
          publisher: "wydawca",
          description: "opis",
          year: 2017,
          count: 20,
          borrowed_count: 4
        }
      }
      should permit(:author, :title, :publisher, :description, :year, :count).
        for(:update, params: params).
        on(:book)
    end
  end

end
