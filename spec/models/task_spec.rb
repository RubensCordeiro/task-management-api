require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'Validations' do
    let(:task) { create(:task) }
    let(:task_2) { create(:task, title: "A title", due_date: Time.new) }

    context 'With valid params' do
      it 'Should create task with all params present' do
        expect(task.save).to be(true)
      end

      it 'Should create task with only mandatory params present' do
        expect(task_2.save).to be(true)
      end
    end

    context 'With invalid params' do
      it 'Should not create task without tirle' do
        task.title = nil
        expect(task.save).to be(false)
      end

      it 'Should not create task without due_date' do
        task.due_date = nil
        expect(task.save).to be(false)
      end

      it 'Should not create task with invalid priority' do
        task.priority = 'random_priority'
        expect(task.save).to be(false)
        expect(task.errors.full_messages).to eq(["Priority Priority must be low, medium or high"])
      end

    end

  end
end
