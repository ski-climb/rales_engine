require 'rails_helper'

describe Merchant do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:updated_at) }
    it { is_expected.to validate_presence_of(:created_at) }
  end

  describe "relationships" do
    it { is_expected.to have_many(:invoices) }
    it { is_expected.to have_many(:items) }
    it { is_expected.to have_many(:transactions) }
    it { is_expected.to have_many(:invoice_items) }
  end

  describe ".revenue_by_day" do
    it "responds to revenue_by_day"do
      expect(Merchant).to respond_to(:revenue_by_day)
    end
  end
end
