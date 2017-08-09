# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shipping, type: :model do
  it { expect(subject).to belong_to :user }
end
