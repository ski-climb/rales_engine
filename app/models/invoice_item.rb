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
  has_many :transactions, through: :invoice

  scope :successful, -> { joins(:transactions).merge(Transaction.successful) }
end
