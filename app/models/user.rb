class User < ActiveRecord::Base
  has_secure_password
  has_many :ideas
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  enum role: %w(default admin)
end
