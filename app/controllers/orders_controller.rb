# frozen_string_literal: true

class OrdersController < ApplicationController
  def index
    @orders = OrdersQuery.new(current_user.orders).run(params[:filter]).decorate
  end

  def show
    @order = current_user.orders.find(params[:id]).decorate
    redirect_to checkout_path(:payment) unless @order.credit_card
  end
end

