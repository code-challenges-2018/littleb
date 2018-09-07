class User < ApplicationRecord
  has_many :inventions

  validates :username, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
end
