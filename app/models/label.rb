class Label < ApplicationRecord
  has_many :label_tasks, dependent: :destroy
  has_many :users, through: :label_tasks
  belongs_to :user

  validates :name, presence: true
end
