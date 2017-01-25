class Transaction < ApplicationRecord
  validates :result, :created_at, :updated_at, :credit_card_number, presence: true
  
  belongs_to :invoice

  enum result: %w(success failed)

  scope :successful, -> { where(result: 'success') }

  def self.on_date(date)
    if date
      where(transactions: {created_at: date})
    else
      all
    end
  end
end
