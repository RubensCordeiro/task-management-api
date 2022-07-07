class UsersMailer < ApplicationMailer
  default from: 'info@task_manager.com'

  def weekly_summary(user)
    @user = user
    @tasks = @user.tasks
    mail(to: @user.email, subject: 'Task summary for this week')
  end

  def send_weekly_summary
    User.each do |user|
      UsersMailer.weekly_summary(user).deliver_now
    end
  end
end
