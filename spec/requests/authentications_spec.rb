require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  let(:base_route) { '/api/v1/authentication' }

  describe 'Authentication' do
    let(:user) { create(:user, username: "username1", password: "password123") }

    it 'authenticates user' do
      post "#{base_route}", params: { username: user.username, password: user.password }
      expect(response).to have_http_status(:created)
    end

    it 'generates error when password is not passed' do
      post "#{base_route}", params: { username: user.username }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'generates error when username is not passed' do
      post "#{base_route}", params: { username: user.username }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'raises error when user is not found' do
      post "#{base_route}", params: { username: 'cleber_machado', password: user.password }
      expect(response).to have_http_status(:not_found)
    end

    it 'raises error when password is wrong' do
      post "#{base_route}", params: { username: user.username, password: 'wrong_password' }
      expect(response).to have_http_status(:unauthorized)
    end

  end
end
