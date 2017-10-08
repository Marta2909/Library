class ChangeTypeOfBookDescription < ActiveRecord::Migration[5.1]
  def change
    change_column :books, :description, :text
  end
end
