class AddIsReturnedToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :is_returned, :boolean
  end
end
