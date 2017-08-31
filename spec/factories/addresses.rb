# frozen_string_literal: true

FactoryGirl.define do
  ADDRESS_TYPE = %w[Billing Shipping]

  factory :address do
    type { ADDRESS_TYPE.sample }
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.html_safe_last_name }
    address { FFaker::AddressUS.street_address }
    city { FFaker::AddressUS.city }
    zip { FFaker::AddressUS.zip_code }
    country { FFaker::AddressUS.country }
    phone '+12345678910'
    user
    order
  end
end
