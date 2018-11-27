class ToppagesController < ApplicationController
  def index
    @ranking_reviews = Review.ranking(4)
    @review_books = Book.find(@ranking_reviews.keys)
    
    @want_ranking_counts = Want.ranking(4)
    @want_books = Book.find(@want_ranking_counts.keys)
    
    @have_ranking_counts = Have.ranking(4)
    @have_books = Book.find(@have_ranking_counts.keys)
  end
end
