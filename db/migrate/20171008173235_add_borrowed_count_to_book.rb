class AddBorrowedCountToBook < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :borrowed_count, :integer
  end
end
