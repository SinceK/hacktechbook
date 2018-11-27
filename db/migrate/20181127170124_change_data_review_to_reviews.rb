class ChangeDataReviewToReviews < ActiveRecord::Migration[5.0]
  def change
    change_column :reviews, :review, :text
  end
end
