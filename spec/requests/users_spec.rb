require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe 'CRUD routes' do
    let(:user) { create(:user, username: "username1", password: "password123") }

    context 'With valid params' do
      it 'Creates user' do
        post "/api/v1/registration", params: { username: user.username, password: user.password }
        expect(response).to have_http_status(:created)
      end

      it 'Updates a user' do
        patch "/api/v1/registration", params: { id: user.id, username: user.username, password: user.password }
        expect(response).to have_http_status(:success)
      end

      it 'Destroys a user' do
        delete "/api/v1/registration", params: { id: user.id }
        expect(response).to have_http_status(:success)
      end
    end

    context 'With invalid params' do
      it 'Raises error when username is missing' do
        post "/api/v1/registration", params: { password: user.password }
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq("error" => "param is missing or the value is empty: username")
      end

      it 'Raises error when password is missing' do
        post "/api/v1/registration", params: { username: user.username }
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq("error" => "param is missing or the value is empty: password")
      end
    end
  end
end
