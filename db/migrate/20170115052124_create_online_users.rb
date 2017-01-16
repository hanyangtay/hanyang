class CreateOnlineUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :online_users do |t|
      t.integer :user_id

      t.timestamps
    end
    add_index :online_users, :user_id
  end
end
