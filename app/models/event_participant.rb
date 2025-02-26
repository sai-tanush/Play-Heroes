class EventParticipant < ApplicationRecord
  belongs_to :play_event
  belongs_to :user
end