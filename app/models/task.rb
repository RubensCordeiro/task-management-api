# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user

  validates :title, :due_date, presence: true
  validates :priority, inclusion: { in: %w[low medium high], message: 'Priority must be low, medium or high' }

  today = Time.zone.now.to_date

  scope :where_urgent, -> { where(urgent: true, finished: false) }
  scope :where_late, -> { where('due_date <= ? AND finished = ?', today, false) }
  scope :where_today, -> { where(due_date: today.all_day, finished: false) }
  scope :where_tomorrow, -> { where(due_date: (today + 1.day).all_day, finished: false) }
  scope :where_next_week, -> { where('due_date BETWEEN ? AND ? AND finished = ?', today, today + 7.days, false) }
  scope :where_finished, -> { where(finished: true) }
end
