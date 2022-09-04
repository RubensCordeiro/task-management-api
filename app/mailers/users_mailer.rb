# frozen_string_literal: true

class UsersMailer < ApplicationMailer
  default from: 'info@task_manager.com'

  def weekly_summary(user)
    @user = user
    @tasks = @user.tasks
    mail(to: @user.email, subject: 'Task summary for this week')
  end
end
