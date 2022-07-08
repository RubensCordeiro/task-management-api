namespace :scheduler do
  desc 'Sends weekly task summary to users'
  task send_weekly_summary: [:environment] do
    User.all.each do |user|
      UsersMailer.weekly_summary(user).deliver_now
    end
  end
end
