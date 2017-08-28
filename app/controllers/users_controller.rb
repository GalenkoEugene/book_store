# frozen_string_literal: true

class UsersController < ApplicationController
  def update
    if current_user.update_attributes(users_params)
      flash[:success] = t('user.seccess_updating_email')
    else
      flash[:danger] = t('review.smth_went_wrong')
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def users_params
    params.require(:user).permit(:email)
  end
end
