class Invoice < ApplicationRecord
  validates :status, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true
  belongs_to :customer
  belongs_to :merchant

  enum status: %w(shipped)
end
