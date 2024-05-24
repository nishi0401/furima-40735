FactoryBot.define do
  factory :item do
    title         { Faker::Book.title }
    description   { Faker::Lorem.sentence }
    price         { Faker::Number.between(from: 300, to: 9_999_999) }
    category      { Category.all.sample }
    condition     { Condition.all.sample }
    shipping_cost { ShippingCost.all.sample }
    prefecture    { Prefecture.all.sample }
    shipping_date { ShippingDate.all.sample }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
