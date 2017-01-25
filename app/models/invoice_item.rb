class InvoiceItem < ApplicationRecord
  validates :quantity,
            :unit_price_in_cents,
            :invoice_id,
            :item_id,
            :created_at,
            :updated_at,
            presence: true
  belongs_to :item
  belongs_to :invoice

  def unit_price
    (unit_price_in_cents / 100.to_f).to_s
  end
end
