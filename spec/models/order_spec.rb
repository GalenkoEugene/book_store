require 'rails_helper'

RSpec.describe Order, type: :model do
  it { expect(subject).to have_many :order_items }
  it { expect(subject).to belong_to :order_status }

  it 'set order status before create' do
    subject.order_status_id= FactoryGirl.create(:order_status).id
    expect(subject).to receive :set_order_status
    subject.save!
  end

  it 'set order status before create' do
    order = subject.send(:set_order_status)
    expect(order.name).to eq 'in_progress'
  end

  it 'update subtotal before save' do
    allow(subject).to receive(:order_items) { [FactoryGirl.build(:order_item)] }
    allow_any_instance_of(OrderItem).to receive(:unit_price).and_return 12.30
    allow_any_instance_of(OrderItem).to receive(:quantity).and_return 4
    subject.send(:update_subtotal)
    expect(subject.subtotal).to eq 49.20
  end
end
