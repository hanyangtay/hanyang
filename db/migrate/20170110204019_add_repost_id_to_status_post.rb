class AddRepostIdToStatusPost < ActiveRecord::Migration[5.0]
  def change
    add_column :status_posts, :repost_id, :integer
    add_index :status_posts, :repost_id
  end
end
