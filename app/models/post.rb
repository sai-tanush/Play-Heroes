class Post < ApplicationRecord
  has_many :post_likes, dependent: :destroy
  belongs_to :user
  validates :description, presence: true
  has_one_attached :media
  validates :media_url, format: { with: URI::regexp(%w[http https]), message: "must be a valid URL" }, allow_blank: true
  has_many :comments, dependent: :destroy
end
