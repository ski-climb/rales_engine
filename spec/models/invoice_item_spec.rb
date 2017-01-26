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
    it { is_expected.to have_many(:transactions) }
  end

  describe ".to_date" do
    context 'given a date' do
      it 'returns invoices on the date' do
        date_1 = '2012-03-16 11:55:05'
        date_2 = '2012-03-07 10:54:55'

        invoices_on_date_1 = create_list(:invoice, 3, created_at: date_1)
        invoices_on_date_2 = create_list(:invoice, 3, created_at: date_2)

        expect(Invoice.on_date(date_1)).to eq invoices_on_date_1
        expect(Invoice.on_date(date_2)).to eq invoices_on_date_2
      end
    end

    context 'given no date' do
      it 'returns all invoices' do
        date = nil
        invoices = create_list(:invoice, 5)

        expect(Invoice.on_date(nil)).to eq invoices
      end
    end
  end

  describe ".successful" do
    context 'unsuccessful transction' do
      it 'returns an empty relation' do
        unsuccessful_transaction = create(:transaction, result: "failed")
        invoice_item = create(:invoice_item, invoice: unsuccessful_transaction.invoice)

        expect(InvoiceItem.count).to eq 1
        expect(InvoiceItem.successful.count).to eq 0
      end
    end

    context 'successful transaction' do
      it 'returns a successful invoice item in an ActiveRecord relation' do
        successful_transaction = create(:transaction, result: "success")
        invoice_item = create(:invoice_item, invoice: successful_transaction.invoice)

        expect(InvoiceItem.count).to eq 1
        expect(InvoiceItem.successful.count).to eq 1
      end
    end

    context 'successful and unsuccessful transactions' do
      it 'returns a successful invoice item in an ActiveRecord relation' do
        invoice = create(:invoice)
        unsuccessful_transaction = create(:transaction, invoice: invoice, result: "failed")
        successful_transaction = create(:transaction, invoice: invoice, result: "success")
        invoice_item = create(:invoice_item, invoice: invoice)

        expect(InvoiceItem.count).to eq 1
        expect(InvoiceItem.successful.count).to eq 1
      end
    end
  end

  describe '#unit_price' do
    it "returns the unit price in dollars" do
      invoice_item = create(:invoice_item, unit_price_in_cents: 12_34)

      expect(invoice_item.unit_price).to eq "12.34"
    end
  end
end
