class PlayEvent < ApplicationRecord
  belongs_to :sport
  belongs_to :host, class_name: 'User', foreign_key: 'host_id'
  has_many :event_participants, dependent: :destroy
  has_many :participants, through: :event_participants, source: :user
  has_many :join_requests, dependent: :destroy
  has_many :pending_requests, -> { where(status: 'pending') }, class_name: 'JoinRequest'
  has_many :event_chats, dependent: :destroy

  validates :sport_type, inclusion: { in: %w(Regular Tournament) }
  validates :event_category, inclusion: { in: %w(Beginner Intermediate Professional) }
  validates :event_start_time, presence: true
  validates :event_end_time, presence: true
  validate :start_time_before_end_time
  validate :start_time_is_future

  def full?
    event_capacity.present? && participants.count >= event_capacity
  end

  def chat_active?
    Time.current < event_start_time
  end

  private

  def start_time_before_end_time
    if event_start_time.present? && event_end_time.present? && event_start_time >= event_end_time
      errors.add(:event_end_time, "must be after the start time")
    end
  end

  def start_time_is_future
    if event_start_time.present? && event_start_time < Time.now
      errors.add(:event_start_time, "must be a future time")
    end
  end

  def event_timeline
    event_start_time
  end

  
end