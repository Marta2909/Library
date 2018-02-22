class AddDeadlineToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :deadline, :datetime
    add_column :orders, :debt, :decimal
  end
end
