class AddCaptionToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :tagline, :string, default: "I don't have a tagline because I'm too lazy to update it."
  end
end
