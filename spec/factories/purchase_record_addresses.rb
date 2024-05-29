FactoryBot.define do
  factory :purchase_record_address do
    postcode { Faker::Number.leading_zero_number(digits: 3) + '-' + Faker::Number.leading_zero_number(digits: 4) }
    prefecture_id { 2 }
    city { Faker::Address.city }
    block { Faker::Address.street_address }
    building { Faker::Company.name }
    phone_number { Faker::Number.leading_zero_number(digits: 11) }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
