FactoryGirl.define do
  factory :item do
    name                { Faker::Pokemon.name }
    description         { Faker::Hipster.sentence(3) }
    unit_price_in_cents { Faker::Number.between(1, 700000) }
    merchant
    created_at          { 1.day.ago }
    updated_at          { DateTime.now }

  end
end
