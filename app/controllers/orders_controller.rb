# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    all_in_one = @orders.includes(:delivery, :order_status, :order_items)
    @orders = OrdersQuery.new(all_in_one).run(params[:filter]).decorate
  end

  def show
    @order = @order.decorate
    redirect_to checkout_path(:confirm) if @order.status == t('order.status.in_progress')
  end
end

