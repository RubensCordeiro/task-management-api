# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repositories::Users do
  describe 'CRUD routes' do
    let(:user) { create(:user, username: 'user1', password: 'password123', email: 'user@mail.com') }
    let(:attributes) { { username: 'username2', password: 'password123', email: 'user@mail.com' } }
    let(:repository) { Repositories::Users.new }
    let(:model) { User }

    context 'with valid parameters' do
      it 'lists all users' do
        user
        expect(repository.index.size).to eq(1)
        expect(repository.index.size).not_to eq(2)
      end

      it 'gets a single user' do
        expect(repository.show(user.id).username).to eq(user.username)
      end

      it 'creates a user' do
        expect(repository.create(attributes).username).to eq(attributes[:username])
      end

      it 'updates a user' do
        expect(repository.update(user.id, attributes)).to be(true)
      end

      it 'destroys user' do
        expect(repository.destroy(user.id).username).to eq(user.username)
        expect(repository.index.size).to eq(0)
      end

      it 'Should check if email exists' do
        user
        expect(repository.find_email(user.email)).to be(true)
      end
    end

    context 'with invalid parameters' do
      it 'Raises error when id is not found' do
        expect(repository.show(999)).to eq({ error: "#{model} not found" })
      end
    end
  end
end
