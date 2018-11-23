class RankingsController < ApplicationController
  def want
    @ranking_counts = Want.ranking
    @books = Book.find(@ranking_counts.keys)
  end
  
  def have
    @ranking_counts = Have.ranking
    @books = Book.find(@ranking_counts.keys)
  end
end
