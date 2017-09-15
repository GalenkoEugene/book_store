ActiveAdmin.register Review do
  permit_params :list, :of, :attributes, :on, :model
  includes :book

  scope :new, default: true do |reviews|
    reviews.where(status: nil)
  end

  scope :processed, default: true do |reviews|
    reviews.where.not(status: nil)
  end

  index do
    selectable_column
    column 'Title' do |review|
      review.book.title
    end
    column 'Date', :created_at
    column 'User' do |review|
      review.user.email
    end
    column 'Status' do |review|
      status_tag(review.status ? 'Approved' : (review.status == false ? 'Rejected' : 'Unprocessed'))
    end
    column '' do |review|
      (link_to 'Approve', approve_admin_review_path(review), method: :put) + ' - ' +
      (link_to 'Reject', reject_admin_review_path(review), method: :put)
    end
  end

  member_action :approve, method: :put do
    review = Review.find(params[:id])
    review.approve!
    redirect_back(fallback_location: admin_reviews_path, notice: 'Approved!')
  end

  member_action :reject, method: :put do
    review = Review.find(params[:id])
    review.reject!
    redirect_back(fallback_location: admin_reviews_path, danger: 'Rejected!')
  end
end
