class OrderItemsController < ApplicationController
  before_action :get_order

  def create
    @order_item = @order.order_items.find_or_initialize_by(book_id: order_item_params[:book_id])
    update_quantity.save
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

  def update_quantity
    qqty = order_item_params[:quantity].to_i
    @order_item.quantity= qqty + @order_item.quantity.to_i
    @order_item
  end
end