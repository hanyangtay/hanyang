class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.integer :liked_post_id, foreign_key: true
      t.integer :liked_user_id, foreign_key: true

      t.timestamps
    end
    
    add_index :likes, [:liked_user_id, :created_at]
    add_index :likes, [:liked_post_id, :created_at]
    add_index :likes, [:liked_post_id, :liked_user_id], unique: true
  end
end