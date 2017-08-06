require 'rails_helper'

RSpec.describe Review, type: :model do
  it { expect(subject).to validate_presence_of :score }
  it { expect(subject).to validate_presence_of :context }
  it {
    expect(subject).to validate_numericality_of(:score).only_integer
      .is_greater_than_or_equal_to(1).is_less_than_or_equal_to(5)
  }
  it { expect(subject).to belong_to :user }
  it { expect(subject).to belong_to :book }
end
