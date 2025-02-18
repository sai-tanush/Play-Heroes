class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Association to sports (many-to-many relationship)
  has_and_belongs_to_many :sports

  has_one_attached :profile_picture
end
