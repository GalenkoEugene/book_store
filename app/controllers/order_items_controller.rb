# frozen_string_literal: true

class OrderItemsController < ApplicationController
  load_and_authorize_resource

  def create
    @order_item = current_order.order_items.find_or_initialize_by(book_id: order_item_params[:book_id])
    session[:order_id] = current_order.id if update_quantity.save
  end

  def update
    @order_item.update_attributes(order_item_params)
    @order_items = current_order.order_items
  end

  def destroy
    @order_item.destroy
    @order_items = current_order.order_items
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :book_id)
  end

  def update_quantity
    qqty = order_item_params[:quantity].to_i
    @order_item.quantity= qqty + @order_item.quantity.to_i
    @order_item
  end
end
