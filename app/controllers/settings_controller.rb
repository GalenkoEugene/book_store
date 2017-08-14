# frozen_string_literal: true

class SettingsController < ApplicationController
  include OutsideDevise

  def new
    @shipping = Shipping.new
    @billing = Billing.new
  end

  def create
    @addresses = AddressesForm.new(params, current_user.id)

    if @addresses.save
      flash.now[:success] = 'Addresses succesfuly updated'
    else
      flash.now[:danger] = t('review.smth_went_wrong')
    end
  end
end
