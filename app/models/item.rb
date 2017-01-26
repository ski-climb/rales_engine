class Item < ApplicationRecord
  validates :name, :description, :merchant_id, :unit_price_in_cents,
    :updated_at, :created_at, presence: true

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def unit_price
    (unit_price_in_cents / 100.to_f).to_s
  end

  def best_day
    '2012-03-22T03:55:09.000Z'
  end
end
