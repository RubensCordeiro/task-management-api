class User < ApplicationRecord
  has_secure_password
  has_many :tasks

  validates :username, length: { minimum: 5 }, uniqueness: true
  validates :password, length: { minimum: 10 }
end
