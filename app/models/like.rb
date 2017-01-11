class Like < ApplicationRecord
  belongs_to :liked_post, class_name: "StatusPost"
  belongs_to :liked_user, class_name: "User"
  
  validates :liked_user_id, presence: true
  validates :liked_post_id, presence: true
end
