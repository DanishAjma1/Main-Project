class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy
  validates :title, presence: true
  validates :author_name, presence: true
  # validates :description, presence:true
  belongs_to :user
end
