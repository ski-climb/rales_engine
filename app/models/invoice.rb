class Invoice < ApplicationRecord
  validates :status, :created_at, :updated_at, presence: true
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: %w(shipped)

  def self.on_date(date)
    if date
      day = Date.parse(date)
      where(invoices: {created_at: date})
    else
      all
    end
  end
end

