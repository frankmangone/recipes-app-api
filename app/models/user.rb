class User < ApplicationRecord
  has_secure_password
  has_secure_token :refresh_token

  validates :email, presence: true, uniqueness: true
  # validates :password
end
