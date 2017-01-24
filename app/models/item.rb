class Item < ApplicationRecord
  validates :name, :description, :merchant_id, :unit_price_in_cents,
    :updated_at, :created_at, presence: true

  belongs_to :merchant
end
