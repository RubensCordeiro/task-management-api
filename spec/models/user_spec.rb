require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    let(:user) { create(:user, username: "user1", password: "password123") }
    context 'with valid parameters' do
      it 'Should create user' do
        expect(user.save).to be(true)
      end
    end

    context 'with invalid paramaters' do
      it 'Should not create user with a too small password' do
        user.password = 'pass'
        expect(user.save).to be(false)
        expect(user.errors.full_messages).to eq(["Password is too short (minimum is 10 characters)"])
      end

      it 'Should not create user with a too small username' do
        user.username = 'u'
        expect(user.save).to be(false)
        expect(user.errors.full_messages).to eq(["Username is too short (minimum is 5 characters)"])
      end
    end
  end
end
