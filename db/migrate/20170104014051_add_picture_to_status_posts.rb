class AddPictureToStatusPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :status_posts, :picture, :string
  end
end
