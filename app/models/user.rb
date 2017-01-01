class User < ApplicationRecord
    attr_accessor :remember_token
    before_save { self.email = email.downcase }
    
    NAME_REGEX = /\A[a-zA-Z0-9\s]{2,}/
    
    validates :name, presence: true, length: { maximum: 50},
            format: { with: NAME_REGEX }
    
    
    validates :email, presence: true, length: { maximum: 255 }, 
        uniqueness: { case_sensitive: false}
        
    STRONG_PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*[0-9])(?=.*[\-\_\/:;,\?'\"\.!@#\$%\^&\*\(\)\+\=])(?=^.{8,})/
    
    has_secure_password
        
    validates :password, presence: true, length: { minimum: 8 },
        format: { with: STRONG_PASSWORD_REGEX}
    
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
    
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
    
    def forget
        update_attribute(:remember_digest, nil)
    end

end
