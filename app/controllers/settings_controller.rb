# frozen_string_literal: true

class SettingsController < ApplicationController
  include OutsideDevise

  def new
    @shipping = current_user.addresses.find_or_initialize_by(type: 'Billing')
    @billing = current_user.addresses.find_or_initialize_by(type: 'Shipping')
  end

  def create
    @addresses = AddressesForm.new(params, current_user.id)
    status = @addresses.save ? :created : :unprocessable_entity
    render json: @addresses.errors, callback: 'parse_errors', status: status
  end
end
