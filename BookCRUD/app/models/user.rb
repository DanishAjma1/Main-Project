class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :role, presence: true, inclusion: { in: %w[admin user] }
  enum role: { admin: "admin", user: "user" }
  has_many :books
  has_many :reviews
end
