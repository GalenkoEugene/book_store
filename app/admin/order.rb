ActiveAdmin.register Order do
  includes :coupon, :order_status
  permit_params :order_status_id, :coupon
  filter :order_status

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
    column('Number') { |order| order.id }
    column('Date of creation') { |order| order.created_at }
    column('State') { |order| order.order_status }
    column { |order| link_to 'Change State', edit_admin_order_path(order) }
  end

  form title: 'edit' do |f|
    inputs 'Details' do
      input :order_status, as: :select, collection: OrderStatus.pluck(:name, :id), include_blank: false
      h3 li "Current status: #{f.order.order_status.name}" unless f.order.new_record?
    end
    panel'Conditions:' do
      h2 " The Admin should be able to choose a state from the provided list of standard states.
      There are the following states:
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
end
