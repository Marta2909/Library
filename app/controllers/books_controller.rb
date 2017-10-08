class BooksController < ApplicationController
  def index
    @books = Book.all.page(params[:page]).per(10)
  end

  def show
    @book = Book.find(params[:id])
  end

  def orderbook
    @book = Book.find(params[:id])
    Order.create(book_id: @book.id, user_id: current_user.id, book_title: @book.title, book_author: @book.author, is_returned: false)
    borrowed_count = @book.borrowed_count + 1
    @book.update_attribute(:borrowed_count, borrowed_count)
    @book.save
    redirect_to orders_path
  end

end
