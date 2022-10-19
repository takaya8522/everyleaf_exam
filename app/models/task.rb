class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :deadline_on, presence: true
  validates :priority, presence: true
  validates :status, presence: true
  enum priority: { 低: 0, 中: 1, 高: 2 }
  enum status: { 未着手: 0, 着手中: 1, 完了: 2 }
  scope :sort_created_at, -> { order("created_at DESC") }
  scope :sort_deadline_on, -> { order("deadline_on") }
  scope :sort_priority, -> { order("priority DESC") }
  scope :search_status, ->(status) { where(status: status) }
  scope :search_title, ->(title) { where('title LIKE ?',"%#{title}%") }
end
