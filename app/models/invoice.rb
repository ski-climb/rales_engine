class Invoice < ApplicationRecord
  validates :status, presence: true
  validates :created_at, presence: true
  validates :updated_at, presence: true


end
