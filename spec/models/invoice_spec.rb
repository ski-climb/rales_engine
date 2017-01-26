require 'rails_helper'

describe Invoice do
  describe "validations" do
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:created_at) }
    it { is_expected.to validate_presence_of(:updated_at) }
  end

  describe "relationships" do
    it { is_expected.to belong_to(:customer) }
    it { is_expected.to belong_to(:merchant) }
    it { is_expected.to have_many(:transactions) }
    it { is_expected.to have_many(:invoice_items) }
    it { is_expected.to have_many(:items).through(:invoice_items) }
  end

  describe "status" do
    let(:invoice) { create(:invoice) }

    it "is 'shipped' by default" do
      expect(invoice.shipped?).to be true
      expect(invoice.status).to eq "shipped"
    end
  end
end
