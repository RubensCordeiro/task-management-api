# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users' do
  describe 'CRUD routes' do
    let(:user) { create(:user, username: 'username1', password: 'password123', email: 'user@mail.com') }
    let(:user2) { create(:user, username: 'username2', password: 'password123', email: 'user2@mail.com') }
    let(:token) { AuthenticationTokenService.encode({ user_id: user.id }) }

    context 'with valid params' do
      it 'Creates user' do
        post '/api/v1/registration', params: { username: 'username', password: 'password123', email: 'mail@mail.com' }
        expect(response).to have_http_status(:created)
      end

      it 'Updates a user' do
        patch '/api/v1/registration',
              headers: { 'Authorization' => "Bearer #{token}" },
              params: { id: user.id, username: user.username, password: user.password, email: user.email }
        expect(response).to have_http_status(:success)
      end

      it 'Destroys a user' do
        delete '/api/v1/registration',
               headers: { 'Authorization' => "Bearer #{token}" },
               params: { id: user.id }
        expect(response).to have_http_status(:success)
      end

      it 'Finds user email' do
        post '/api/v1/users/email_checker',
             params: { email: user.email }
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid params' do
      it 'Raises error when username is missing' do
        post '/api/v1/registration', params: { password: user.password, email: user.email }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq('error' => 'param is missing or the value is empty: username')
      end

      it 'Raises error when password is missing' do
        post '/api/v1/registration', params: { username: user.username, email: user.email }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq('error' => 'param is missing or the value is empty: password')
      end
    end

    it 'Prevents one user to access another user data' do
      patch '/api/v1/registration',
            headers: { 'Authorization' => "Bearer #{token}" },
            params: { id: user2.id, username: user.username, password: user.password }
      expect(response).to have_http_status(:forbidden)
    end
  end
end
