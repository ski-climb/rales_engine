require 'rails_helper'

describe Item do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:unit_price_in_cents) }
    it { is_expected.to validate_presence_of(:merchant_id) }
    it { is_expected.to validate_presence_of(:updated_at) }
    it { is_expected.to validate_presence_of(:created_at) }
  end

  describe 'relationships' do
    it { is_expected.to belong_to(:merchant) }
    it { is_expected.to have_many(:invoice_items) }
    it { is_expected.to have_many(:invoices).through(:invoice_items) }

  end

  describe '.most_revenue' do
    it 'responds to most_revenue' do
      expect(Item).to respond_to(:most_revenue)
    end
  end


  describe '.most_items' do
    it 'responds to most_items' do
      expect(Item).to respond_to(:most_items)
    end
  end
  
  describe '.best_day' do
    it { is_expected.to respond_to(:best_day) }
  end
end
