FactoryBot.define do
  factory :task do
    title { "A title" }
    summary { "A summary" }
    description { "A description" }
    due_date { Time.new }
    priority { "low" }
    urgent { false }
    finished { false }
  end
end
