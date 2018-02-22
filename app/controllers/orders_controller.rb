class OrdersController < ApplicationController

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
