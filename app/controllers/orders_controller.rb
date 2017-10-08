class OrdersController < ApplicationController
  def new
    redirect_to :create
  end

  def create
    @book = Book.find(params[:id])
    @order = Order.new
    to_borrow = @book.count - @book.borrowed_count
    if to_borrow > 0
      if @order.save
        flash[:notice] = "Książka wypożyczona. Oddaj jak przeczytasz"
        @book.borrowed_count = @book.borrowed_count + 1
        @book.update_attribute(borrowedcount)
        redirect_to orders_path
      else
        flash[:notice] = "Spróbuj jeszcze raz"
        redirect_to root_path
      end
    else
      flash[:notice] = "Wszystkie książki wypożyczone"
      redirect_to root_path
    end
  end

  def index
    @orders = Order.where(user_id: current_user.id).order(created_at: :DESC).page(params[:page]).per(10)
  end

  def returnbook
    @order = Order.find(params[:id])
    @book = Book.where("title = ?", @order.book_title).first
    @order.is_returned = true
    borrowed_count = @book.borrowed_count - 1
    @book.update_attribute(:borrowed_count, borrowed_count)
    @order.save
    @book.save
    redirect_to root_path
  end
end
