class User < ApplicationRecord
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
end
