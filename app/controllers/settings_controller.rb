# frozen_string_literal: true

class SettingsController < ApplicationController
  include OutsideDevise

  def new
    @shipping = Shipping.new
    @billing = Billing.new
  end

  def create
    @addresses = AddressesForm.submit(params, current_user.id)
  end
end
