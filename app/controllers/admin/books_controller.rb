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
      flash[:notice] = "Książka dodana"
      redirect_to admin_books_path
    else
      flash[:notice] = "Spróbuj jeszcze raz"
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
      flash[:notice] = "Zaktualizowano dane o książce"
      redirect_to admin_books_path
    else
      flash[:notice] = "Spróbuj jeszcze raz"
      render :new
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      flash[:notice] = "Książka usunięta z biblioteczki. Nie można już wypożyczyć żadnej sztuki"
      redirect_to admin_books_path
    else
      flash[:notice] = "Spróbuj jeszcze raz"
      rener :index
    end
  end

  private

  def book_params
    params.require(:book).permit(:author, :title, :publisher, :description, :year, :count)
  end

  def authenticate
    authenticate_or_request_with_http_basic "Podaj hasło!" do |name, password|
      name == "admin" && password == "admin"
    end
  end

end
