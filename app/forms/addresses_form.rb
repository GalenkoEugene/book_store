# frozen_string_literal: true

class AddressesForm
  attr_reader :params
  attr_accessor :billing, :shipping

  include ActiveModel::Model
  include Virtus.model

  def initialize(params, user_id)
    @params = params
    safely_add_user(user_id) if User.exists?(user_id)
  end

  def save
    return false unless valid?
    persist!
    true
  end

private

  def persist!
    billing.save
    shipping.save
  end

  def billing
    @billing = Billing.new(params_for(:billing))
  end

  def shipping
    @shipping = Shipping.new(params_for(:shipping))
  end

  def valid?
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
