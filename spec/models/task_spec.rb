# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task do
  describe 'Validations' do
    let(:user) { create(:user, username: 'user1', password: 'password123', email: 'user@mail.com') }
    let(:task) { create(:task, user_id: user.id) }
    let(:task2) { create(:task, title: 'A title', due_date: Time.zone.now, user_id: user.id) }

    context 'with valid params' do
      it 'creates task with all params present' do
        expect(task.save).to be(true)
      end

      it 'creates task with only mandatory params present' do
        expect(task2.save).to be(true)
      end
    end

    context 'with invalid params' do
      it 'does not create task without tirle' do
        task.title = nil
        expect(task.save).to be(false)
      end

      it 'does not create task without due_date' do
        task.due_date = nil
        expect(task.save).to be(false)
      end

      it 'does not create task with invalid priority' do
        task.priority = 'random_priority'
        expect(task.save).to be(false)
        expect(task.errors.full_messages).to eq(['Priority Priority must be low, medium or high'])
      end
    end
  end
end
