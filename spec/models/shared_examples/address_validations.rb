# frozen_string_literal: true

shared_examples_for 'address_validations' do
  it { expect(subject).to belong_to :user }
  it { expect(subject).to validate_presence_of :first_name }
  it { expect(subject).to validate_presence_of :last_name }
  it { expect(subject).to validate_presence_of :address }
  it { expect(subject).to validate_presence_of :city }
  it { expect(subject).to validate_presence_of :zip }
  it { expect(subject).to validate_presence_of :country }
  it { expect(subject).to validate_presence_of :phone }
  it { expect(subject).to validate_length_of(:first_name).is_at_most(50) }
  it { expect(subject).to validate_length_of(:last_name).is_at_most(50) }
  it { expect(subject).to validate_length_of(:address).is_at_most(50) }
  it { expect(subject).to validate_length_of(:city).is_at_most(50) }
  it { expect(subject).to validate_length_of(:country).is_at_most(50) }
  it { expect(subject).to validate_length_of(:phone).is_at_most(15) }
end
