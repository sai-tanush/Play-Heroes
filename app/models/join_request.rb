class JoinRequest < ApplicationRecord
  belongs_to :user
  belongs_to :play_event
  

  validates :status, inclusion: { in: ['pending', 'accepted', 'rejected'] }
  
  validates :user_id, uniqueness: { scope: :play_event_id, 
    message: "You already have a request for this event" }
end
