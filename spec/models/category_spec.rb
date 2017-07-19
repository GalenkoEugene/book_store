require 'rails_helper'

RSpec.describe Category, type: :model do
  it { expect(subject).to validate_presence_of :type_of }
end
