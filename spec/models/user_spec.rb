# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { expect(subject).to validate_uniqueness_of(:email).case_insensitive }
  it { expect(subject).to validate_presence_of :email }
  it { expect(subject).to have_one :billing }
  it { expect(subject).to have_one :shipping }
  it { expect(subject).to have_many :reviews }
  it { expect(subject).to have_many :addresses }
end
