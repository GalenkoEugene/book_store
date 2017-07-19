require 'rails_helper'

RSpec.describe User, type: :model do
  it { expect(subject).to validate_uniqueness_of(:email).case_insensitive }
  it { expect(subject).to validate_presence_of :email }
end
