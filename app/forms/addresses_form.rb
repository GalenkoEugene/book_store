# frozen_string_literal: true

class AddressesForm
  include ActiveModel::Model
  include Virtus.model

  attr_reader :params, :user
  attr_accessor :billing, :shipping

  def initialize(params, user_id)
    @params = params
    safely_add_user(user_id) if User.exists?(user_id)
    @user = User.find(user_id)
  end

  def save
    return false unless valid?
    persist!
    true
  end

  def errors
    errors = {}
    errors[:billing] = billing.errors
    errors[:shipping] = shipping.errors
    errors
  end

  def billing
    fresh_bill = user.addresses.find_or_initialize_by(type: 'Billing')
    fresh_bill.assign_attributes(params_for(:billing))
    @billing ||= fresh_bill
  end

  def shipping
    fresh_shipp = user.addresses.find_or_initialize_by(type: 'Shipping')
    fresh_shipp.assign_attributes(params_for(:shipping))
    @shipping ||= fresh_shipp
  end

private

  def persist!
    billing.save
    shipping.save
  end

  def valid?
    shipping.valid?
    billing.valid? && shipping.valid?
  end

  def safely_add_user(user_id)
    @params[:billing][:user_id] = user_id
    @params[:shipping][:user_id] = user_id
  end

  def params_for(type)
    params.require(type).permit(:first_name, :last_name, :address, :city, :zip, :country, :phone, :user_id)
  end
end
