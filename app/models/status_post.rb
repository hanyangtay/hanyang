class StatusPost < ApplicationRecord
    belongs_to :user
    belongs_to :original_post, class_name: "StatusPost", foreign_key: "repost_id"
    has_many :reposts, class_name: "StatusPost", foreign_key: "repost_id"
    
    has_many :like_relationships, class_name:  "Like",
                                  foreign_key: "liked_post_id",
                                  dependent:   :destroy
    
    has_many :liked_users, through: :like_relationships
    
    default_scope -> { order(created_at: :desc) }
    mount_uploader :picture, PictureUploader
    validates :user_id, presence: true
    validates :content, presence: true, length: { maximum: 140 }
    validate :picture_size
    
    def like(other_user)
        liked_users << other_user unless self.liked_by?(other_user)
    end
    
    def unlike(other_user)
        liked_users.delete(other_user)
    end
    
    def liked_by?(other_user)
        liked_users.include?(other_user)
    end

        
    
    private
    
    def picture_size
        if picture.size > 8.megabytes
            errors.add(:picture, "should be less than 8MB")
        end
    end
    
end
