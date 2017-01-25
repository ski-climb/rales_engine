require 'rails_helper'

describe InvoiceItem do
  describe "validations" do
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_presence_of(:unit_price_in_cents) }
    it { is_expected.to validate_presence_of(:invoice_id) }
    it { is_expected.to validate_presence_of(:item_id) }
    it { is_expected.to validate_presence_of(:created_at) }
    it { is_expected.to validate_presence_of(:updated_at) }
  end

  describe "relationships" do
    it { is_expected.to belong_to(:invoice) }
    it { is_expected.to belong_to(:item) }
  end

  describe '#unit_price' do
    it "returns the unit price in dollars" do
      invoice_item = create(:invoice_item, unit_price_in_cents: 12_34)

      expect(invoice_item.unit_price).to eq "12.34"
    end
  end
end
