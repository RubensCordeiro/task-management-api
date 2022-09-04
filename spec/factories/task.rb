# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title { 'A title' }
    summary { 'A summary' }
    description { 'A description' }
    due_date { Time.zone.now }
    priority { 'low' }
    urgent { false }
    finished { false }
  end
end
