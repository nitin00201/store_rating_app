class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { in: 20..60 }
  validates :address, presence: true, length: { maximum: 400 }
  validates :role, presence: true, inclusion: { in: %w[normal_user store_owner admin] }

  has_many :stores, dependent: :destroy
  has_many :ratings, dependent: :destroy

  def admin?
    role == "admin"
  end

  def store_owner?
    role == "store_owner"
  end

  def normal_user?
    role == "normal_user"
  end
end
