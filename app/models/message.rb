class Message < ApplicationRecord
    belongs_to :user
    validates :content, presence: true, length: {maximum: 255}
    validates :user_id, presence: true
    
    scope :for_display, -> { order(:created_at).last(20) }
end
