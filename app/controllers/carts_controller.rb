class CartsController < ApplicationController
  before_action :order_items
  before_action :set_coupon, only: :update

  def show
  end

  def update
    current_order.update_attributes(coupon_id: @coupon_id) if @coupon_id
  end

  private

  def set_coupon
    @coupon_id = Coupon.find_by_name(params[:name]).try(:id) || false
  end

  def order_items
    @order_items = current_order.order_items
  end
end
