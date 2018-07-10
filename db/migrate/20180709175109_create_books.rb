class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :book_num
      t.integer :image_count
      t.string :title
      t.string :authors
      t.integer :year
      t.string :publisher
      t.string :isbn
      t.integer :user_id
      t.timestamps
    end
  end
end
