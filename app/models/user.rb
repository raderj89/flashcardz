require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  before_save { self.email = email.downcase }

  has_many :rounds, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password

  validates :password, presence: true, length: { minimum: 6 }
end
