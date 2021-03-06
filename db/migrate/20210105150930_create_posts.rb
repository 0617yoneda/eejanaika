class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :customer_id, null: false
      t.integer :category_id, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.string :try, null: false
      t.string :image_id, null: false
      t.timestamps
    end
  end
end
