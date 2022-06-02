require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  describe 'CRUD helpers' do
    let(:user) { create(:user, username: "user1", password: "password123") }
    let(:user_2) { create(:user, username: "user2", password: "password123") }
    let(:task) { create(:task, user_id: user.id) }
    let(:task_2) { create(:task, user_id: user_2.id) }
    let(:attributes) { { task: { title: "A brand new title", due_date: Time.new } } }
    let(:token) { AuthenticationTokenService.encode({ user_id: user.id }) }

    context 'with valid params' do
      it 'Should get all user tasks' do
        task
        get "/api/v1/tasks",
            headers: { 'Authorization' => "Bearer #{token}" }
        expect(response).to have_http_status(:success)
      end

      it 'Should get desired task, provided user owns it' do
        task
        get "/api/v1/tasks/#{task.id}",
            headers: { 'Authorization' => "Bearer #{token}" }
        expect(response).to have_http_status(:success)
      end

      it 'Should create task' do
        post '/api/v1/tasks',
             headers: { 'Authorization' => "Bearer #{token}" },
             params: attributes
        expect(response).to have_http_status(:success)
        expect(Task.last.user_id).to eq(user.id)
      end

      it 'Should not create task with mandatory param missing' do
        post '/api/v1/tasks',
             headers: { 'Authorization' => "Bearer #{token}" },
             params: { task: { due_date: Time.new } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'Should not create task with mandatory param equal to nil' do
        post '/api/v1/tasks',
             headers: { 'Authorization' => "Bearer #{token}" },
             params: { task: { title: nil, due_date: Time.new } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'Should edit a task, provided user owns it' do
        patch "/api/v1/tasks/#{task.id}",
              headers: { 'Authorization' => "Bearer #{token}" },
              params: attributes
        expect(response).to have_http_status(:success)
        expect(Task.find(task.id).title).to eq(attributes[:task][:title])
      end

      it 'Should not get desired task when user doesnt own it' do
        task
        get "/api/v1/tasks/#{task_2.id}",
            headers: { 'Authorization' => "Bearer #{token}" }
        expect(response).to have_http_status(:forbidden)
      end

      it 'Should destroy task' do
        delete "/api/v1/tasks/#{task.id}",
               headers: { 'Authorization' => "Bearer #{token}" }
        expect(response).to have_http_status(:success)
      end
    end
  end
end
