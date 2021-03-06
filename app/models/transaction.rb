class Transaction < ApplicationRecord
  validates :result, :created_at, :updated_at, :credit_card_number, presence: true
  
  belongs_to :invoice

  enum result: %w(failed success)

  scope :successful, -> { where(result: 'success') }
end
