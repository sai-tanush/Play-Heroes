class Post < ApplicationRecord
  belongs_to :user
  validates :description, presence: true
  validates :media_url, format: { with: URI::regexp(%w[http https]), message: "must be a valid URL" }, allow_blank: true
end
