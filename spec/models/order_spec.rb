require 'rails_helper'

RSpec.describe Order, type: :model do
  it { expect(subject).to have_many :order_items }
  it { expect(subject).to belong_to :order_status }
  it { expect(subject).to belong_to :coupon }
  it { expect(subject).to belong_to :user }
  it { expect(subject).to belong_to :credit_card }
  it { expect(subject).to belong_to :delivery }

  it 'set order status before create' do
    subject.user_id = FactoryGirl.create(:user).id
    subject.order_status_id= FactoryGirl.create(:order_status).id
    expect(subject).to receive :set_order_status
    subject.save!
  end

  it 'set order status before create' do
    status_id = subject.send(:set_order_status)
    expect(OrderStatus.find(status_id).name).to eq 'in_progress'
  end

  it 'update subtotal before save' do
    allow(subject).to receive(:order_items) { [FactoryGirl.build(:order_item)] }
    allow_any_instance_of(OrderItem).to receive(:unit_price).and_return 12.30
    allow_any_instance_of(OrderItem).to receive(:quantity).and_return 4
    subject.send(:update_subtotal)
    expect(subject.subtotal).to eq 49.20
  end

  describe 'scopes' do
    before(:all) do
      @in_progress_id = FactoryGirl.create(:order, :in_progress).id
      @wrong_ids = []
      2.times { @wrong_ids << FactoryGirl.create(:order, :delivered).id }
    end

    context 'order_id where status in progress' do
      it 'finds order_id with status in_progress' do
        expect(Order.in_progress).to eq @in_progress_id
      end

      it 'not eq other status' do
        expect(@wrong_ids).not_to include Order.in_progress
      end
    end

    context 'finds proper status' do
      it 'find only in_progress' do
        expect(Order.where_status(:in_progress).first.order_status.name).to eq 'in_progress'
      end

      let(:statuses) { Order.where_status(:delivered).map(&:order_status).map(&:name) }

      it 'contain only one type of statuses'do
        expect(statuses.uniq.size).to eq 1
      end

      it 'contain only one type of statuses'do
        expect(statuses.uniq).to eq ['delivered']
      end
    end
  end
end
