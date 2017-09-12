# frozen_string_literal: true

class OrdersController < ApplicationController
  load_and_authorize_resource

  def index
    @orders = OrdersQuery.new(personal_orders).run(params[:filter]).decorate
  end

  def show
    @order = personal_orders.find(params[:id]).decorate
    redirect_to checkout_path(:confirm) if @order.status == t('order.status.in_progress')
  end

  private

  def personal_orders
    Order.includes(:delivery, :order_status, :order_items).accessible_by(current_ability)
  end
end

