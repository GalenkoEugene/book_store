class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token, only: :create

  def destroy
    return redirect_back(fallback_location: root_path) unless params[:user][:confirm] == '1'
    super
  end
end
