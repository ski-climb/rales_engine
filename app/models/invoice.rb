class Invoice < ApplicationRecord
  validates :status, :created_at, :updated_at, presence: true
  belongs_to :customer
  belongs_to :merchant

  enum status: %w(shipped)
end
