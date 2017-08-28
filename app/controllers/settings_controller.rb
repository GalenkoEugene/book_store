# frozen_string_literal: true

class SettingsController < ApplicationController
  before_action :authenticate_user!
  include OutsideDevise

  def new
    @addresses = AddressesForm.new(user_id: current_user.id)
  end

  def create
    @addresses = AddressesForm.new(addresses_params)
    status = @addresses.save ? :created : :unprocessable_entity
    render json: @addresses.errors, callback: 'parse_errors', status: status
  end

  private

  def addresses_params
    %i[shipping billing].each { |type| params[type][:user_id] = current_user.id }
    params
  end
end
