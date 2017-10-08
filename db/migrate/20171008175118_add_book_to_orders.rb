class AddBookToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :book_title, :string
    add_column :orders, :book_author, :string
  end
end
