require "rails_helper"

describe Admin::BooksController, type: :controller do

  def http_login
    user = 'admin'
    pw = 'admin'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end

  context 'when user is logged' do
    before(:each) do
      http_login
      @first_book = Book.create!(author: 'Author1', title: 'Title1', publisher: 'Publisher1', description: 'Description1', year: 2017, count: 20, borrowed_count: 1)
      @second_book = Book.create!(author: 'Author2', title: 'Title2', publisher: 'Publisher2', description: 'Description2', year: 2017, count: 20, borrowed_count: 1)
    end

    describe "GET index" do
      it 'shows the books list' do
        get :index
        expect(response).to be_success
        expect(assigns(:books)).not_to be_nil
        expect(assigns(:books)).to eq([@first_book,@second_book])
      end
    end

    describe "GET new" do
      it "creates new Book with borrowed_count eq to 0 without saving to the database" do
        get :new
        expect(response).to be_success
        expect(assigns(:book).title).to be_nil
        expect(assigns(:book).author).to be_nil
        expect(assigns(:book).description).to be_nil
        expect(assigns(:book).publisher).to be_nil
        expect(assigns(:book).year).to be_nil
        expect(assigns(:book).count).to be_nil
        expect(assigns(:book).borrowed_count).to eq 0
      end
      it 'renders new template' do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST create" do
      context 'with valid data' do
        it 'creates a book and saves it to database' do
          expect { post :create, params: {book: { author: 'Author1', title: "Title1", publisher: "Publisher1", description: "Description1", year: 2017, count: 20 } } }.to change(Book, :count).by(1)
          post :create, params: {book: { author: 'Author1', title: "Title1", publisher: "Publisher1", description: "Description1", year: 2017, count: 20 } }
          expect(assigns(:book).save).to be true
        end

        it 'establishes a flash message' do
          post :create, params: {book: { author: 'Author1', title: "Title1", publisher: "Publisher1", description: "Description1", year: 2017, count: 20 } }
          expect(flash[:notice]).to eq "Book added"
        end

        it 'redirects to admin_books_path' do
          post :create, params: {book: { author: 'Author1', title: "Title1", publisher: "Publisher1", description: "Description1", year: 2017, count: 20 } }
          expect(response).to redirect_to admin_books_path
        end
      end
      context 'with invalid data' do
        it 'doesn\'t create a book and doesn\'t save it to database' do
          expect { post :create, params: {book: { title: "Title1", publisher: "Publisher1", description: "Description1", year: 2017, count: 20 } } }.to change(Book, :count).by(0)
          post :create, params: {book: { title: "Title1", publisher: "Publisher1", description: "Description1", year: 2017, count: 20 } }
          expect(assigns(:book).save).to be false
        end

        it 'establishes a flash message' do
          post :create, params: {book: { title: "Title1", publisher: "Publisher1", description: "Description1", year: 2017, count: 20 } }
          expect(flash[:notice]).to eq "Try again"
        end

        it 'redirects to admin_books_path' do
          post :create, params: {book: { title: "Title1", publisher: "Publisher1", description: "Description1", year: 2017, count: 20 } }
          expect(response).to render_template :new
        end
      end
    end

    describe "GET edit" do
      it "should render edit template" do
        get :edit, params: {id: @first_book.id}
        expect(response).to be_success
        expect(response).to render_template :edit
      end
    end

    describe "PUT update" do
      context 'with valid attribute' do
        before(:each) do
          put :update, params: {id: @first_book.id, book: {title: 'new title'}}
        end

        it "updates book attributes" do
          expect(assigns(:book).save).to be true
          expect(Book.first.title).to eq 'new title'
        end

        it 'establishes a flash message' do
          expect(flash[:notice]).to eq "Book updated"
        end

        it 'redirects to admin_books_path' do
          expect(response).to redirect_to admin_books_path
        end
      end

      context 'with invalid attribute' do
        before(:each) do
          put :update, params: {id: @first_book.id, book: {title: nil}}
        end

        it "updates book attributes" do
          expect(assigns(:book).save).to be false
          expect(Book.first.title).not_to be_nil
        end

        it 'establishes a flash message' do
          expect(flash[:notice]).to eq "Try again"
        end

        it 'renders edit action' do
          expect(response).to render_template :edit
        end
      end
    end


    describe "GET show" do
      it "renders show view" do
        get :show, params: {id: Book.first.id}
        expect(response).to be_success
        expect(response).to render_template :show
      end

      it 'establishes not_returned_books' do
        user = User.create!(name: 'Jon')
        o1 = Order.create!(book_id: @first_book.id, user_id: user.id, book_title: 'title1', book_author: 'author1', is_returned: false, deadline: Time.now+7.days, debt: 0)
        o2 = Order.create!(book_id: @first_book.id, user_id: user.id, book_title: 'title2', book_author: 'author2', is_returned: true, deadline: Time.now+7.days, debt: 0)
        get :show, params: {id: Book.first.id}
        expect(assigns(:not_returned_books)).to eq([o1])
      end
    end

    describe "DELETE destroy" do
      context 'when success' do
        it "deletes a book from a database" do
          expect { delete :destroy, params: {id: Book.last.id} }.to change(Book, :count).by(-1)
        end

        it 'establishes a flash message' do
          delete :destroy, params: {id: Book.last.id}
          expect(flash[:notice]).to eq "Book removed from library. There are no copies to borrow"
        end

        it 'redirects to admin_books_path' do
          delete :destroy, params: {id: Book.last.id}
          expect(response).to redirect_to admin_books_path
        end
      end

      it "should not be successful if the book doesn't exist" do
        expect { delete :destroy, params: {id: Book.last.id+1} }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  context 'when user isn\'t logged' do
    before(:each) do
      @first_book = Book.create!(author: 'Author1', title: 'Title1', publisher: 'Publisher1', description: 'Description1', year: 2017, count: 20, borrowed_count: 1)
      @second_book = Book.create!(author: 'Author2', title: 'Title2', publisher: 'Publisher2', description: 'Description2', year: 2017, count: 20, borrowed_count: 1)
    end

    describe "GET index" do
      it 'doesn\'t show the books list' do
        get :index
        expect(response).not_to be_success
      end
    end

    describe "GET new" do
      it "doen\'t create new Book " do
        get :new
        expect(response).not_to be_success
      end
      it 'doesn\'t render new template' do
        get :new
        expect(response).not_to render_template :new
      end
    end

    describe "POST create" do
      it 'doesn\'t be a success' do
        post :create, params: {book: { author: 'Author1', title: "Title1", publisher: "Publisher1", description: "Description1", year: 2017, count: 20 } }
        expect(response).not_to be_success
      end
    end

    describe "GET edit" do
      it "doesn\'t render edit template" do
        get :edit, params: {id: @first_book.id}
        expect(response).not_to be_success
        expect(response).not_to render_template :edit
      end
    end

    describe "PUT update" do
      it "doesn't work" do
        put :update, params: {id: @first_book.id, book: {title: 'new title'}}
        expect(response).not_to be_success
      end
    end

    describe "GET show" do
      it "doesn\'t render show view" do
        get :show, params: {id: Book.first.id}
        expect(response).not_to be_success
        expect(response).not_to render_template :show
      end

      it 'doesn\t establish not_returned_books' do
        user = User.create!(name: 'Jon')
        o1 = Order.create!(book_id: @first_book.id, user_id: user.id, book_title: 'title1', book_author: 'author1', is_returned: false, deadline: Time.now+7.days, debt: 0)
        o2 = Order.create!(book_id: @first_book.id, user_id: user.id, book_title: 'title2', book_author: 'author2', is_returned: true, deadline: Time.now+7.days, debt: 0)
        get :show, params: {id: Book.first.id}
        expect(assigns(:not_returned_books)).not_to eq([o1])
        user.destroy!
      end
    end

    describe "DELETE destroy" do
      it "doesn\'t delete a book from a database" do
        expect { delete :destroy, params: {id: Book.last.id} }.to change(Book, :count).by(0)
      end
    end
  end
end
