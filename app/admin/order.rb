ActiveAdmin.register Order do
  includes :coupon, :order_status
  permit_params :order_status_id, :coupon
  filter :order_status
  decorate_with OrderDecorator

  scope :in_progress, default: true do |tasks|
    tasks.processing_list
  end

  scope :delivered do |tasks|
    tasks.where_status(:delivered)
  end

  scope :canceled do |tasks|
    tasks.where_status(:canceled)
  end

  index do
    column('Number') { |order| order.number }
    column('Date of creation') { |order| order.creation_date }
    column('State') { |order| order.status }
    column { |order| link_to 'Change State', edit_admin_order_path(order) }
  end

  form title: 'edit', decorate: true do |f|
    inputs 'Details' do
      input :order_status, as: :select, collection: OrderStatus.pluck(:name, :id), include_blank: false
      h3 li "Current status: #{f.order.status}" unless f.order.new_record?
    end
    panel'Conditions:' do
      h2 "There are the following states:
      in_progress - A user makes a purchase - is displayed in the In Progress tab;
      in_queue - A user has paid an order. The order is waiting for processing – is displayed in the In Progress tab;
      in_delivery - An order in delivery - is displayed in the In Progress tab;
      delivered - An order is delivered - is displayed in the Delivered tab;
      canceled - An order was canceled - displays in Canceled tab.
      The first two are assigned to an order automatically by system, Admin should not be able to set it up. Delivered status can be assigned by Admin to an order only in case if it has the In Delivery status. The Canceled status can be assigned to an order by Admin in any status."
    end
    para 'Press cancel to return to the list without saving.'
    actions
  end

  controller do
    def update
      action = -> { redirect_to edit_admin_order_path(params[:id]), notice: 'Status was successfully updated!' }
      super { action.call and return } if valid_transition?
      redirect_to edit_admin_order_path(params[:id]), danger: 'It is forbidden to change into this status!'
    end

    private

    def valid_transition?
      Order.find(params[:id]).order_status.valid_step?(params[:order][:order_status_id])
    end
  end
end
