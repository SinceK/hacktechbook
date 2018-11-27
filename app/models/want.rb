class Want < Ownership
  def self.ranking(limit = 10)
    self.group(:book_id).order('count_book_id DESC').limit(limit).count(:book_id)
  end
end
