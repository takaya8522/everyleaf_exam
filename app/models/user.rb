class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_and_belongs_to_many :users

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  # enum管理者権限用
  # enum admin: { あり: true, なし: false }
end