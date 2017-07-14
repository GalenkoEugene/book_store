# frozen_string_literal: true

module HomeHelper
  def sign_helper
    if user_signed_in?
      link_to t('button.log_out'), destroy_user_session_path, :method => :delete
    else
      link_to t('button.log_in'), new_user_session_path, :method => :get
    end
  end
end
