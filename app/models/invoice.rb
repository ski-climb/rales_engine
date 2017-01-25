class Invoice < ApplicationRecord
  validates :status, :created_at, :updated_at, presence: true
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions

  enum status: %w(shipped)
end
