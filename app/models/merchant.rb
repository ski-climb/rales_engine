class Merchant < ApplicationRecord
  validates :name, :updated_at, :created_at, presence: true

  has_many :items
end
