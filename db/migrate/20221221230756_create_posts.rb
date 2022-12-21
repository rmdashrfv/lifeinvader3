class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.text :content
      t.integer :user_id
      t.integer :likes_count, default: 0

      t.timestamps
    end
  end
end
