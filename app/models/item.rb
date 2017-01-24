class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :merchant_id, presence: true
  validates :unit_price_in_cents, presence: true
  validates :updated_at, presence: true
  validates :created_at, presence: true

  belongs_to :merchant
end
