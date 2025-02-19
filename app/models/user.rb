class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_and_belongs_to_many :sports
  has_one_attached :profile_picture
  has_many :posts, dependent: :destroy
end
