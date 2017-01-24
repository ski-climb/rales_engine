FactoryGirl.define do
  factory :merchant do
    name       Faker::GameOfThrones.character
    created_at 1.day.ago
    updated_at Time.now
  end
end
