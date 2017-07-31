class OrderItemsController < ApplicationController
  before_action :get_order

  def create
    @order_item = @order.order_items.new(order_item_params)
    @order.save
    session[:order_id] = @order.id
  end

  def update
    @order_item = @order.order_items.find(params[:id])
    @order_item.update_attributes(order_item_params)
    @order_items = @order.order_items
  end

  def destroy
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items
  end

  private

  def get_order
    @order = current_order
  end

  def order_item_params
    params.require(:order_item).permit(:quantity, :book_id)
  end
end
