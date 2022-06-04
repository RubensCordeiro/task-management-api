class Task < ApplicationRecord
  belongs_to :user

  validates :title, :due_date, presence: true
  validates :priority, inclusion: { in: %w(low medium high), message: 'Priority must be low, medium or high' }

  today = Time.new.to_date

  scope :where_urgent, -> { where(urgent: true) }
  scope :where_late, -> { where("due_date <= ?", today) }
  scope :where_today, -> { where(due_date: today.all_day) }
  scope :where_tomorrow, -> { where("due_date = ?", (today - 1.day).all_day) }
  scope :where_next_week, -> { where("due_date BETWEEN ? AND ?", today, today + 7.days) }
end
