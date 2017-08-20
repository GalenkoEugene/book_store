# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreditCard, type: :model do
    context 'validations' do
    it { expect(subject).to validate_presence_of :number }
    it { expect(subject).to validate_presence_of :name }
    it { expect(subject).to validate_presence_of :mm_yy }
    it { expect(subject).to validate_presence_of :cvv }

    it { expect(subject).to have_many :orders }
  end
end
