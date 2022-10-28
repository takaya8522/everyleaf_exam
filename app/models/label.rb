class Label < ApplicationRecord
  has_many :label_tasks
  has_many :users, through: :label_tasks

  validates :name, presence: true
end
