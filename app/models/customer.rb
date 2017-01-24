class Customer < ApplicationRecord
  validates :first_name, :last_name, :created_at, :updated_at, presence: true
end
