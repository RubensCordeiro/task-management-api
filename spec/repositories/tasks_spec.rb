# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repositories::Tasks do
  describe 'CRUD routes' do
    let(:user) { create(:user, username: 'user1', password: 'password123', email: 'user@mail.com') }
    let(:attributes) { { user_id: user.id, title: 'A brand new title', due_date: Time.zone.now } }
    let(:repository) { described_class.new }
    let(:task) { create(:task, user_id: user.id) }
    let(:urgent_task) { create(:task, user_id: user.id, urgent: true) }
    let(:late_task) { create(:task, user_id: user.id, due_date: 2.days.ago) }
    let(:today_task) { create(:task, user_id: user.id, due_date: 3.hours.ago) }
    let(:tomorrow_task) { create(:task, user_id: user.id, due_date: 1.day.ago) }
    let(:next_week_tasks) { create(:task, user_id: user.id, due_date: 8.days.from_now) }
    let(:finished_tasks) { create(:task, user_id: user.id, finished: true) }
    let(:model) { Task }

    context 'with valid params' do
      it 'returns all user tasks' do
        task
        expect(repository.index(user.id).size).to eq(1)
      end

      it 'Gets a single task' do
        expect(repository.show(task.id).title).to eq(task.title)
      end

      it 'Creates a task' do
        expect(repository.create(attributes).title).to eq(attributes[:title])
      end

      it 'updates a user' do
        expect(repository.update(task.id, attributes)).to be(true)
      end

      it 'destroys user' do
        expect(repository.destroy(task.id).title).to eq(task.title)
        expect(repository.index(user.id).size).to eq(0)
      end

      it 'returns all user tasks' do
        task
        urgent_task
        expect(repository.index(user.id, 'urgent').size).to eq(1)
      end

      it 'returns only late tasks' do
        task
        late_task
        expect(repository.index(user.id, 'late').size).to eq(1)
      end

      it 'returns only today tasks' do
        tomorrow_task
        today_task
        expect(repository.index(user.id, 'today').size).to eq(1)
      end

      it 'returns only tomorrow tasks' do
        task
        tomorrow_task
        expect(repository.index(user.id, 'today').size).to eq(1)
      end

      it 'returns only next_week tasks' do
        task
        next_week_tasks
        expect(repository.index(user.id, 'next_week').size).to eq(1)
      end

      it 'returns only finished tasks' do
        task
        finished_tasks
        expect(repository.index(user.id, 'finished').size).to eq(1)
      end
    end

    context 'with invalid parameters' do
      it 'Raises error when id is not found' do
        expect(repository.show(999)).to eq({ error: "#{model} not found" })
      end
    end
  end
end
