class Merchant < ApplicationRecord

  validates :name, :updated_at, :created_at, presence: true

  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items

  def revenue(date)
    invoices.on_date(date)
      .joins(:transactions, :invoice_items)
      .merge(Transaction.successful)
      .sum('unit_price_in_cents * quantity')
  end

  def self.most_items(quantity)
    joins(:invoice_items)
      .group('merchants.id')
      .order('sum(invoice_items.quantity) DESC')
      .take(quantity)
  end
end
