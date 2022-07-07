require 'rails_helper'

Rails.application.load_tasks

RSpec.describe 'scheduler.rake' do
  let(:send_weekly_summary) { Rake::Task['scheduler:send_weekly_summary'].invoke }
  let(:user) { create(:user, username: 'user1', email: 'user1@mail.com') }
  let(:user2) { create(:user, username: 'user2', email: 'user2@mail.com') }

  it 'sends emails to all users' do
    create(:task, user_id: user.id)
    create(:task, user_id: user2.id)
    expect { send_weekly_summary }.to change { ActionMailer::Base.deliveries.count }.by(2)
  end
end
