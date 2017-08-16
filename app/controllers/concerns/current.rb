# frozen_string_literal: true

module Current
  thread_mattr_accessor :user

  extend ActiveSupport::Concern
  included { helper_method :set_current_user }

  def set_current_user
    Current.user = current_user
    yield
  ensure
    Current.user = nil
  end
end
