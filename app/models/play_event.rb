class PlayEvent < ApplicationRecord
  belongs_to :sport
  belongs_to :host, class_name: 'User', foreign_key: 'host_id' # Added class name and foreign key
  has_many :event_participants
  has_many :participants, through: :event_participants, source: :user

  validates :sport_type, inclusion: { in: %w(Regular Tournament) }
  validates :event_category, inclusion: { in: %w(Beginner Intermediate Professional) }
  validates :event_start_time, presence: true
  validates :event_end_time, presence: true
  validates :event_date, presence: true
  validate :start_time_before_end_time
  validate :date_is_future

  private

  def start_time_before_end_time
    if event_start_time.present? && event_end_time.present? && event_start_time >= event_end_time
      errors.add(:event_end_time, "must be after the start time")
    end
  end

  def date_is_future
    if event_date.present? && event_date < Date.today
      errors.add(:event_date, "must be a future date")
    end
  end
end