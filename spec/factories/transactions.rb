FactoryGirl.define do
  factory :transaction do
    invoice
    credit_card_number { rand(10000) }
    result             0
    created_at         { 1.day.ago }
    updated_at         { DateTime.now }
  end
end
