# frozen_string_literal: true

class ReviewsController < ApplicationController
  respond_to :js
  def create
    @review = Review.new(review_params)
    return flash.now[:success] = t('review.thanks_message') if @review.save
    flash.now[:danger] = t('review.smth_went_wrong')
  end

  private

  def review_params
    params.require(:review).permit(:book_id, :user_id, :score, :context)
  end
end
