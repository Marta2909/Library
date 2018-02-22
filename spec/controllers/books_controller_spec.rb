require 'rails_helper'

RSpec.describe BooksController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Book. As you add validations to Book, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      author: 'a',
      title: 't',
      description: 'desc',
      year: 2018,
      publisher: 'p',
      count: 10
    }
  }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_success
    end
    it 'renders index template' do
      get :index
      expect(response).to render_template(:index)
    end
    it 'shows all books in the list' do
      book1 = Book.create!(valid_attributes)
      book2 = Book.create!(valid_attributes)
      get :index
      expect(assigns(:books).count).to eq 2
    end
    it 'redirects to search_results if there are search_keywords' do
      get :index, params: {search_keywords: 'aaa'}
      expect(response).to redirect_to search_results_path
    end
  end

  describe "GET #show" do
    before(:each) do
      @book1 = Book.create!(valid_attributes)
      @book2 = Book.create!(author: 'author', title: 'title', description: 'description', year: 2013, publisher: 'publisher', count: 12)
    end
    it "returns a success response" do
      get :show, params: {id: @book2.id}
      expect(response).to be_success
    end
    it 'shows a proper book details' do
      get :show, params: {id: @book2.id}
      expect(assigns(:book).count).to eq(12)
    end
  end

  describe "GET #search_results" do
    before(:each) do
      @book1 = Book.create!(valid_attributes)
      @book2 = Book.create!(author: 'book creator', title: 'special super book', description: 'description', year: 2013, publisher: 'publisher', count: 12)
    end
    it 'searches a book by author' do
      get :search_results, params: {search_keywords: 'creator'}
      expect(assigns(:search_results).count).to eq 1
    end
    it 'searches a book by title' do
      get :search_results, params: {search_keywords: 'special'}
      expect(assigns(:search_results).count).to eq 1
    end
    it 'searches a book by author or title' do
      get :search_results, params: {search_keywords: 'aaa'}
      expect(assigns(:search_results).count).to eq 0
    end
    it 'renders a search_results action' do
      get :search_results, params: {search_keywords: 'aaa'}
      expect(response).to render_template('search_results')
    end
  end
end
