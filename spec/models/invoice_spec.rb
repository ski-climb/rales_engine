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

  describe ".on_date" do
    context "given date" do
      it "returns only invoices on date" do
        date = '2012-03-27 14:53:59 UTC'

        create_list(:invoice, 3, created_at: date)
        create_list(:invoice, 2)

        expect(Invoice.count).to eq 5
        expect(Invoice.on_date(date).count).to eq 3
      end
    end

    context "no date given" do
      it "returns all invoices" do
        date = nil
        create_list(:invoice, 3)

        expect(Invoice.on_date(date)).to eq Invoice.all
      end
    end
  end
end
