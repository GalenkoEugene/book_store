# frozen_string_literal: true

module HomeHelper
  def log_out_helper
    divider = '<li class="divider" role="separator"></li>'.html_safe
    divider + li(link_to t('button.log_out'), destroy_user_session_path, method: :delete) if user_signed_in?
  end

  def log_in_up_helper
    if user_signed_in?
      li(link_to t('button.my_account'), '')
    else
      li(link_to t('button.log_in'), new_user_session_path) +
      li(link_to t('button.sign_up'), new_user_registration_path)
    end
  end

  private

  def li(teg)
    "<li>#{teg}</li>".html_safe
  end
end
