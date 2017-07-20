# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  it { expect(subject).to validate_presence_of :type_of }
  it { expect(subject).to validate_uniqueness_of :type_of }
end
