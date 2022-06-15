# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :tasks

  validates :username, presence: true, length: { minimum: 5 }, uniqueness: true
  validates :password, presence: true, length: { minimum: 10 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
end
