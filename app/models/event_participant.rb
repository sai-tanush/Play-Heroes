class EventParticipant < ApplicationRecord
  belongs_to :play_event
  belongs_to :user

  validates :user_id, uniqueness: { scope: :play_event_id }
end