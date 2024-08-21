class Book < ApplicationRecord
  has_many :reviews
  # validates :title, presence:true
  # validates :author_name,presence:true
  # validates :description, presence:true
end
