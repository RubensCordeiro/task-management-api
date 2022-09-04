# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersMailer, type: :mailer do
  let(:user) { create(:user, username: 'user1', email: 'user1@mail.com') }
  let(:user2) { create(:user, username: 'user2', email: 'user2@mail.com') }
  let(:task) { create(:task, user_id: user.id) }
  let(:weekly_summary) { described_class.weekly_summary(user) }

  describe 'send weekly summary' do
    it 'renders the headers' do
      expect(weekly_summary.subject).to eq('Task summary for this week')
      expect(weekly_summary.from).to eq(['info@task_manager.com'])
      expect(weekly_summary.to).to eq([user.email])
    end

    it 'renders the body' do
      expect(weekly_summary.body.encoded).not_to be_empty
    end

    it 'sends email' do
      create(:task, user_id: user.id)
      create(:task, user_id: user.id)
      expect { weekly_summary.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
