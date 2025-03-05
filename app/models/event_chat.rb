class EventChat < ApplicationRecord
  belongs_to :play_event
  belongs_to :user
end
