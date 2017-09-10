# frozen_string_literal: true

class AddressesController < ApplicationController
  def index
    @addresses = AddressesForm.new(user_id: current_user.id)
  end

  def create
    @addresses = AddressesForm.new(params)
    status = @addresses.save ? :created : :unprocessable_entity
    render json: @addresses.errors, callback: 'parse_errors', status: status
  end
end
