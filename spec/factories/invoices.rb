FactoryGirl.define do
  factory :invoice do
    customer
    merchant

    created_at { 1.day.ago }
    updated_at { DateTime.now }
  end
end
