class OrdersController < ApplicationController
  def index
    @orders = OrdersQuery.new(current_user.orders).run(params[:filter]).decorate
  end

  def show
  end
end
