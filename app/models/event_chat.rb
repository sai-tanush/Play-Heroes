class EventChat < ApplicationRecord
  belongs_to :play_event
  belongs_to :user

  validates :message, 
            presence: true, 
            length: { maximum: 500 }

  # Scope for recent messages
  scope :recent, -> { order(created_at: :desc).limit(50) }
end