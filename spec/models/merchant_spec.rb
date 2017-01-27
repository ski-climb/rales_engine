require 'rails_helper'

describe Merchant do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:updated_at) }
    it { is_expected.to validate_presence_of(:created_at) }
  end

  describe 'relationships' do
    it { is_expected.to have_many(:invoices) }
    it { is_expected.to have_many(:items) }
    it { is_expected.to have_many(:transactions) }
    it { is_expected.to have_many(:invoice_items) }
    it { is_expected.to have_many(:customers).through(:invoices) }
  end

  describe '.most_revenue' do
    it 'responds to most_revenue' do
      expect(Merchant).to respond_to(:most_revenue)
    end
  end

  describe '.most_items' do
    it 'responds to most_items' do
      expect(Merchant).to respond_to(:most_items)
    end
  end

  describe ".revenue_by_day" do
    it "responds to revenue_by_day"do
      expect(Merchant).to respond_to(:revenue_by_day)
    end
  end

  describe "#customers_with_pending_invoices" do
    it { is_expected.to respond_to(:customers_with_pending_invoices)}
  end

  describe "#favorite_customer" do
    it { is_expected.to respond_to(:favorite_customer) }
  end
end
