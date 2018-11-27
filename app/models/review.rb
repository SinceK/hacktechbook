class Review < ApplicationRecord
  validates :review, presence: true, length: { maximum: 255 }
  validates :rating, presence: true

  belongs_to :user
  belongs_to :book
  
  def self.book_average(book_id)
    self.where(book_id: book_id).average(:rating)
  end
  
  def self.ranking
    self.group(:book_id).order('average_rating DESC').limit(10).average(:rating)
  end
end
