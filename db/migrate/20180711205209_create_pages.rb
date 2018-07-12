class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.string :url
      t.integer :book_id
      t.timestamps
    end
  end
end
