FactoryGirl.define do
  factory :invoice_item do
    unit_price_in_cents { Faker::Number.between(1, 700000) }
    quantity            { Faker::Number.between(1,20) }
    item
    invoice

    created_at { 1.day.ago }
    updated_at { DateTime.now }
  end
end
