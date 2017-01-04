class CreateStatusPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :status_posts do |t|
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :status_posts, [:user_id, :created_at]
  end
end
