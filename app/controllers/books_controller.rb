class BooksController < ApplicationController
  def index
    if params[:search_keywords]
      redirect_to search_results_path
    else
      @books = Book.all.page(params[:page]).per(10)
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def orderbook
    @book = Book.find(params[:id])
    Order.create(book_id: @book.id, user_id: current_user.id, book_title: @book.title, book_author: @book.author, is_returned: false, deadline: Time.now+7.days, debt: 0)
    borrowed_count = @book.borrowed_count + 1
    @book.update_attribute(:borrowed_count, borrowed_count)
    @book.save
    redirect_to orders_path
  end

  def search_results
    @search_results = Book.where("author LIKE ? OR title LIKE ?", "%#{params[:search_keywords]}%", "%#{params[:search_keywords]}%")
    render action: :search_results
  end

end
