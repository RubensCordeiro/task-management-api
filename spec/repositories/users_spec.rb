require 'rails_helper'

RSpec.describe Repositories::Users do
  describe 'CRUD routes' do
    let(:user) { create(:user, username: "user1", password: "password123") }
    let(:attributes) {{username: 'username2', password: 'password123'}}
    let(:repository) {Repositories::Users.new}
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
    end

    context 'with invalid parameters' do
    end

  end
end
