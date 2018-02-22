class Admin::BooksController < ApplicationController
  before_action :authenticate

  def index
    @books = Book.all
  end

  def new
    @book = Book.new(borrowed_count: 0)
  end

  def create
    @book = Book.new(book_params)
    @book.borrowed_count = 0
    if @book.save
      flash[:notice] = 'Book added'
      redirect_to admin_books_path
    else
      flash[:notice] = 'Try again'
      render :new
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book.update_attributes(book_params)
    if @book.save
      flash[:notice] = 'Book updated'
      redirect_to admin_books_path
    else
      flash[:notice] = 'Try again'
      render :edit
    end
  end

  def show
    @book = Book.find(params[:id])
    @not_returned_books = @book.orders.where("is_returned = ?", false)
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      flash[:notice] = 'Book removed from library. There are no copies to borrow'
      redirect_to admin_books_path
    else
      flash[:notice] = 'Try again'
      render :index
    end
  end

  private

  def book_params
    params.require(:book).permit(:author, :title, :publisher, :description, :year, :count)
  end

  def authenticate
    authenticate_or_request_with_http_basic 'Enter password' do |name, password|
      name == 'admin' && password == 'admin'
    end
    session[:admin] = 'admin'
  end

end
