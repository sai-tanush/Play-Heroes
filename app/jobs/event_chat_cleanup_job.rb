
class EventChatCleanupJob < ApplicationJob
  queue_as :default

  def perform
    # Find events that have started
    started_events = PlayEvent.where('event_start_time <= ?', Time.current)
    
    started_events.each do |event|
      # Delete all chats for the event
      event.event_chats.destroy_all
    end
  end
end