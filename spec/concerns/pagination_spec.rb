require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  describe 'With pagination params provided' do
    let(:user) { create(:user, username: "user1", password: "password123") }
    let(:task) { create(:task, user_id: user.id) }
    let(:token) { AuthenticationTokenService.encode({ user_id: user.id }) }

    it 'Should return defualt paginated results' do
      FactoryBot.create_list(:task, 30, user_id: user.id)
      get "/api/v1/tasks/all/1",
          headers: { 'Authorization' => "Bearer #{token}" }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).length).to eq(10)
    end

    it 'Should return next item with offset' do
      FactoryBot.create_list(:task, 30, user_id: user.id)
      get "/api/v1/tasks/all/2",
          headers: { 'Authorization' => "Bearer #{token}" }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).first["id"]).to eq(Task.first.id + 10)
    end

    # WILL NOT TEST FOR OTHER PAGINATION CASES AT THIS MOMENT.


  end
end
