require 'bcrypt'

class User < ApplicationRecord
  include BCrypt

  validates :username,
            presence: true,
            format: {with: /\A[a-zA-Z0-9_]{2,60}\z/},
            length: {minimum: 2, maximum: 60}
  validates :password,
            presence: true,
            length: {minimum: 5, maximum: 60}

  has_secure_password

  scope :find_by_username, -> (username) { where('username' => username) }

  def valid_password(password, user)
    BCrypt::Password.new(user.password_digest) == password
  end
end
