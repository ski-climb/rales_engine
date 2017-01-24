FactoryGirl.define do
  factory :customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    created_at { 1.day.ago }
    updated_at { DateTime.now }
  end
end
