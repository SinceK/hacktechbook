class ReviewsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    book_id = params["reviews"]["book_id"];
    if Review.exists?(user_id: current_user.id, book_id: book_id)
      flash[:danger] = 'この本はレビュー済です。'
      redirect_to book_url(id: book_id)
    else
      @review = current_user.reviews.build(review_params)
      if @review.save
        flash[:success] = 'レビューを保存しました。'
      else
        flash[:danger] = 'レビューの保存に失敗しました。'
      end
      redirect_to book_url(id: @review.book_id)
    end
  end

  def destroy
    @review.destroy
    flash[:success] = 'レビューを削除しました。'
    redirect_to book_url(id: @review.book_id)
  end
  
  private
  
  def review_params
    params.require(:reviews).permit(:rating, :review, :book_id)
  end
  
  def correct_user
    @review = current_user.reviews.find_by(id: params[:id])
    unless @review
      redirect_to root_url
    end
  end
end
