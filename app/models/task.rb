class Task < ApplicationRecord
  validates :title, :due_date, presence: true
  validates :priority, inclusion: {in: %w(low medium high), message: 'Priority must be low, medium or high'}
end
