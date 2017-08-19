# frozen_string_literal: true

class AddressesForm
  include ActiveModel::Model
  include Virtus.model

  attr_reader :params, :target

  def initialize(params = false)
    @save = false
    @params = params
    @target = Order.find_by(id: order_id) || User.find_by(id: user_id) || User.new
  end

  def save
    @save = true
    return false unless valid?
    persist!
    true
  end

  def errors
    { billing: billing.errors, shipping: shipping.errors }
  end

  def billing
    fresh_bill = target.addresses.find_or_initialize_by(type: 'Billing')
    fresh_bill.assign_attributes(params_for(:billing)) if save?
    @billing ||= fresh_bill
  end

  def shipping
    fresh_shipp = target.addresses.find_or_initialize_by(type: 'Shipping')
    fresh_shipp.assign_attributes(params_for(:shipping)) if save?
    @shipping ||= fresh_shipp
  end

private

  def user_id
    params.fetch(:user_id, false) || (params[:billing][:user_id] if nested?)
  end

  def order_id
    params.fetch(:order_id, false) || (params[:billing][:order_id] if nested?)
  end

  def nested?
    params.fetch(:billing, false)
  end

  def save?
    @save
  end

  def persist!
    billing.save
    shipping.save
  end

  def valid?
    shipping.valid?
    billing.valid? && shipping.valid?
  end

  def params_for(type)
    params.require(type).permit(:first_name, :last_name, :address, :city, :zip, :country, :phone, :user_id, :order_id)
  end
end
