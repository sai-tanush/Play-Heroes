class CreateSportSessionsJob < ApplicationJob
    queue_as :default
  
    def perform
      # events that have ended but haven't been processed
      completed_events = PlayEvent.where('event_end_time < ? AND processed = ?', Time.current, false)
      
      completed_events.each do |event|
        # Duration in minutes
        duration = ((event.event_end_time - event.event_start_time) / 60).to_i
        
        # Create sport_session for each participant
        event.participants.each do |user|
          SportSession.create!(
            user_id: user.id,
            sport_id: event.sport_id,
            duration_minutes: duration,
            played_on: event.event_end_time.to_date
          )
        end
        
        # Mark event as processed
        event.update(processed: true)
      end
    end
  end