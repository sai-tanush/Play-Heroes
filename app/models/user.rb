class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_and_belongs_to_many :sports
  has_one_attached :profile_picture
  has_many :posts, dependent: :destroy
  has_many :post_likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :event_participants
  has_many :play_events
  has_many :joined_events, through: :event_participants, source: :play_event
  has_many :hosted_events, class_name: 'PlayEvent', foreign_key: 'host_id'
  has_many :join_requests, dependent: :destroy
  has_many :pending_sent_requests, -> { where(status: 'pending') }, class_name: 'JoinRequest'
  has_many :event_chats
end
