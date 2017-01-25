class Transaction < ApplicationRecord
  validates :result, :created_at, :updated_at, :credit_card_number, presence: true
  
  belongs_to :invoice

  enum result: %w(success failed)

  scope :successful, -> { where(result: 'success') }
end