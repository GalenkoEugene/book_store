# frozen_string_literal: true

class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    if @review.save
      flash[:success] = t('review.thanks_message')
    else
      flash[:danger] = t('review.smth_went_wrong')
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def review_params
    params.require(:review).permit(:book_id, :user_id, :score, :context)
  end
end
