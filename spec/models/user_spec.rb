# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe 'Validations' do
    let(:user) { create(:user, username: 'user1', password: 'password123', email: 'user@mail.com') }
    let(:user2) { create(:user, username: 'user2', password: 'password123', email: 'user@mail.com') }

    context 'with valid parameters' do
      it 'creates user' do
        expect(user.save).to be(true)
      end
    end

    context 'with invalid paramaters' do
      it 'does not create user with a too small password' do
        user.password = 'pass'
        expect(user.save).to be(false)
        expect(user.errors.full_messages).to eq(['Password is too short (minimum is 10 characters)'])
      end

      it 'does not create user with a too small username' do
        user.username = 'u'
        expect(user.save).to be(false)
        expect(user.errors.full_messages).to eq(['Username is too short (minimum is 5 characters)'])
      end

      it 'does not create user without username' do
        user.username = nil
        expect(user.save).to be(false)
        expect(user.errors.full_messages).to eq(["Username can't be blank",
                                                 'Username is too short (minimum is 5 characters)'])
      end

      it 'does not create user without password' do
        user.password = nil
        expect(user.save).to be(false)
        expect(user.errors.full_messages).to eq(["Password can't be blank",
                                                 'Password is too short (minimum is 10 characters)'])
      end

      it 'does not create user without email' do
        user.email = nil
        expect(user.save).to be(false)
        expect(user.errors.full_messages).to eq(['Email is invalid'])
      end

      it 'does not create user with invalid email' do
        user.email = 'user_mail_com'
        expect(user.save).to be(false)
        expect(user.errors.full_messages).to eq(['Email is invalid'])
      end

      it 'does not create user when email already registered' do
        user
        expect { user2.save }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
