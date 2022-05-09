require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  describe 'CRUD helpers' do
    let(:user) { create(:user, username: "user1", password: "password123") }
    let(:user_2) { create(:user, username: "user2", password: "password123") }
    let(:task) { create(:task, user_id: user.id) }
    let(:task_2) { create(:task, user_id: user_2.id) }
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

      it 'Should not get desired task when user doesnt own it' do
        task
        get "/api/v1/tasks/#{task_2.id}",
            headers: { 'Authorization' => "Bearer #{token}" }
        expect(response).to have_http_status(:forbidden)
      end

    end
  end
end
