class Merchant < ApplicationRecord

  validates :name, :updated_at, :created_at, presence: true

  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items

  def revenue(date)
    invoices.on_date(date)
      .joins(:invoice_items)
      .merge(InvoiceItem.successful)
      .sum('unit_price_in_cents * quantity')
  end

  def self.revenue_by_day(date)
    joins(:invoice_items)
    .merge(Invoice.on_date(date))
    .merge(InvoiceItem.successful)
    .sum('unit_price_in_cents * quantity')
  end
end
