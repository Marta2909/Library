class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :description
      t.integer :year
      t.string :publisher

      t.timestamps
    end
  end
end
