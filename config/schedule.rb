every 1.hour do
    runner "EventChatCleanupJob.perform_now"
  end