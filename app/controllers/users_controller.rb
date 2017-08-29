# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def update
    if current_user.update_attributes(users_params)
      flash[:success] = t('user.seccess_updating_email')
    else
      flash[:danger] = t('review.smth_went_wrong')
    end
    redirect_back(fallback_location: root_path)
  end

  def update_password
    return update if current_user.valid_password?(params[:user][:current_password])
    redirect_to settings_path(current_user), notice: t('notice.wrong_password')
  end

  private

  def users_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
