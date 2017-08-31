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
      @order = FactoryGirl.create(:order, :in_progress)
      @wrong_ids = []
      2.times { @wrong_ids << FactoryGirl.create(:order, :delivered).id }
    end

    context 'order_id where status in progress' do
      it 'finds order_id with status in_progress' do
        user = @order.user
        FactoryGirl.create_list(:order, 2, :in_queue, user: user)
        expect(user.orders.in_progress).to eq @order.id
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

    context 'find processing_order "in_queue" for last checkout step' do
      before { FactoryGirl.create(:order, :in_queue) }
      it 'finds processing_order' do
        expect(Order.processing_order.order_status.name).to eq 'in_queue'
      end
    end
  end

  context "callbacks" do
    it { expect(subject).to callback(:update_subtotal).before(:save) }
    it { expect(subject).to callback(:update_total).before(:save) }
    it { expect(subject).to callback(:connect_to_user).before(:save) }
    it { expect(subject).to callback(:set_order_status).before(:validation).on(:create) }
  end

  describe 'public methods' do
    context 'responds to its methods' do
      it { expect(subject).to respond_to(:subtotal_item_total) }
      it { expect(subject).to respond_to(:shipping_price) }
      it { expect(subject).to respond_to(:subtotal) }
      it { expect(subject).to respond_to(:discount) }
      it { expect(subject).to respond_to(:finalize) }
      it { expect(subject).to respond_to(:total) }
    end

    describe '#discount' do
      let(:order) { FactoryGirl.create(:order, coupon: coupon) }

      context 'when apply coupon' do
        let(:coupon) { FactoryGirl.create(:coupon, value: 7.00) }
        it 'return amount of discount' do
          expect(order.discount).to eq 7.00
        end
      end

      context 'when no coupon' do
        let(:coupon) { nil }

        it 'return zero' do
          expect(order.discount).to eq 0.00
        end
      end
    end

    describe '#subtotal' do
      let(:book) { FactoryGirl.create(:book, cost: 3.5) }
      let(:order_item) { FactoryGirl.create(:order_item, book: book, quantity: 2) }

      it 'sum all items in order' do
        subject =  FactoryGirl.build(:order, order_items: [order_item])
        expect(subject.subtotal.to_f).to eq 7.0
      end
    end

    describe '#subtotal_item_total' do
      it 'sum total price without shipping' do
        allow(subject).to receive_messages(subtotal: 15.2, discount: 3.1)
        expect(subject.subtotal_item_total).to eq 12.1
      end
    end

    describe '#shipping_price' do
      let(:type) { FactoryGirl.create(:delivery, price: 12.22) }

      it 'return shipping price' do
        subject = FactoryGirl.create(:order, delivery: type)
        expect(subject.shipping_price).to eq 12.22
      end
    end

    describe '#total' do
      it 'calculate total price' do
        allow(subject).to receive_messages(subtotal_item_total: 12.22, shipping_price: 5.5)
        expect(subject.total).to eq 17.72
      end
    end

    describe '#finalize' do
      let(:order_in_progress) { FactoryGirl.create(:order, :in_progress) }

      it { expect(order_in_progress.order_status.name).to eq 'in_progress' }

      it 'change status to "in_queue"' do
        order_in_progress.finalize
        expect(order_in_progress.order_status.name).to eq 'in_queue'
      end
    end
  end
end
