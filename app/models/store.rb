class Store < ApplicationRecord
  belongs_to :user   # Store owner
  has_many :ratings, dependent: :destroy

  validates :name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :address, presence: true, length: { maximum: 400 }

  def average_rating
    ratings.average(:value).to_f.round(2)
  end
end
