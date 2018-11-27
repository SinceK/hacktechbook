class Book < ApplicationRecord
  validates :isbn, presence: true, length: { maximum: 13 }
  validates :title, presence: true, length: { maximum: 255 }
  validates :url, presence: true, length: { maximum: 255 }
  
  has_many :ownerships
  has_many :users, through: :ownerships
  has_many :wants
  has_many :want_users, through: :wants, class_name: 'User', source: :user
  has_many :haves, class_name: 'Have'
  has_many :have_users, through: :haves, class_name: 'User', source: :user
  has_many :reviews
  has_many :review_users, through: :reviews, class_name: 'User', source: :user

end
