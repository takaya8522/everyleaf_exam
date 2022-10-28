class Task < ApplicationRecord
  belongs_to :user
  has_many :label_tasks, dependent: :destroy
  has_many :labels, through: :label_tasks

  validates :title, presence: true
  validates :content, presence: true
  validates :deadline_on, presence: true
  validates :priority, presence: true
  validates :status, presence: true

  # enum優先度・テータス用
  enum priority: { 低: 0, 中: 1, 高: 2 }
  enum status: { 未着手: 0, 着手中: 1, 完了: 2 }

  # scope検索・ソート機能用
  scope :default_order, -> { order("created_at DESC") }
  scope :sort_deadline_on, -> { order("deadline_on") }
  scope :sort_priority, -> { order("priority DESC") }
  scope :search_status, ->(status) {
    return if status.blank?
    where(status: status) }
  scope :search_title, ->(title) {
    return if title.blank?
    where('title LIKE ?',"%#{title}%") }
  scope :search_label, ->(label) {
    return if label.blank?
    where(id: LabelTask.where(label_id: label).pluck(:task_id))}
end
