# frozen_string_literal: true

class UsersController < ApplicationController
  respond_to :js

  def update
    if current_user.update_attributes(users_params)
      flash.now[:success] = t('user.seccess_updating_email')
    else
      flash.now[:danger] = t('review.smth_went_wrong')
    end
  end

  private

  def users_params
    params.require(:user).permit(:email)
  end
end
