class User < ApplicationRecord
    
    has_many :status_posts, dependent: :destroy
    has_many :messages, dependent: :destroy
    has_many :active_relationships, class_name: "Relationship",
                                    foreign_key: "follower_id",
                                    dependent: :destroy
    has_many :passive_relationships, class_name: "Relationship",
                                    foreign_key: "followed_id",
                                    dependent: :destroy
    has_many :following, through: :active_relationships, source: :followed
    has_many :followers, through: :passive_relationships
    
    has_many :like_relationships, class_name:  "Like",
                                  foreign_key: "liked_user_id",
                                  dependent:   :destroy
    
    has_many :liked_posts, through: :like_relationships

    
    attr_accessor :remember_token, :activation_token, :reset_token
    mount_uploader :avatar, AvatarUploader



    before_save :downcase_email
    before_create :create_activation_digest
    
    validates :name, presence: true, length: { maximum: 50}, uniqueness: true
    
    
    validates :email, presence: true, length: { maximum: 255 }, 
        uniqueness: { case_sensitive: false}
        
    STRONG_PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*[0-9])(?=.*[\-\_\/:;,\?'\"\.!@#\$%\^&\*\(\)\+\=])(?=^.{8,})/
    
    has_secure_password
        
    validates :password, presence: true, length: { minimum: 8 },
        format: { with: STRONG_PASSWORD_REGEX}, allow_nil: true
        
    validate :avatar_size

    validates :tagline, presence: true, length: { maximum: 140 }
    
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? 
        BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    
    def User.new_token
        SecureRandom.urlsafe_base64
    end
    
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end
    
    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end
    
    def forget
        update_attribute(:remember_digest, nil)
    end
    
    def activate
        UserMailer.notify_admin(self).deliver_now
        update_columns(activated: true, activated_at: Time.zone.now)
    end
    
    def send_activation_email
        UserMailer.account_activation(self).deliver_now
    end
    
    def create_reset_digest
        self.reset_token = User.new_token
        update_columns(reset_digest: User.digest(reset_token), 
                        reset_sent_at: Time.zone.now)
    end
    
    def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
    end
    
    def password_reset_expired?
        reset_sent_at < 2.hours.ago
    end
    
    def feed
        following_ids = "SELECT followed_id FROM relationships
                            WHERE follower_id = :user_id"
         StatusPost.where("user_id IN (#{following_ids}) OR user_id = :user_id", 
                            user_id: id)
    end
    
    def follow(other_user)
        following << other_user unless self.following?(other_user)
    end
    
    def unfollow(other_user)
        following.delete(other_user)
    end
        
    def following?(other_user)
        following.include?(other_user)
    end
    
    def like(other_post)
        liked_posts << other_post unless self.like?(other_post)
    end
    
    def unlike(other_post)
        liked_posts.delete(other_post)
    end
        
    def like?(other_post)
        liked_posts.include?(other_post)
    end
    
    def is_online
        update_attribute(:online, true)
    end
    
    def is_offline
        update_attribute(:online, false)
    end
    
    
    
    private
        
        def downcase_email
            self.email = email.downcase
        end
        
        def create_activation_digest
            self.activation_token = User.new_token
            self.activation_digest = User.digest(activation_token)
        end
        
        def avatar_size
            if avatar.size > 8.megabytes
                errors.add(:avatar, "should be less than 8MB")
            end
        end

end
