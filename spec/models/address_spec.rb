# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  include_examples 'address_validations'
end
