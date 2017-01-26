class Customer < ApplicationRecord
  validates :first_name, :last_name, :created_at, :updated_at, presence: true

  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices
  has_many :invoice_items, through: :invoices

  def favorite_merchant
    merchants
      .joins(:invoices, :transactions)
      .merge(Transaction.successful)
      .group('merchants.id')
      .order('count(merchants.id) DESC')
      .first
  end
end
