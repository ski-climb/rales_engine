require 'rails_helper'

describe "Invoice Items importer" do
  let(:bad) { './spec/fixtures/bad/invoice_items.csv' }
  let(:good) { './spec/fixtures/good/invoice_items.csv' }

  context "unsuccessful import" do
    it "raises an error and does not save any invoice items to the database" do
      expect{InvoiceItemsImporter.new(bad).import}
        .to raise_error(ActiveRecord::RecordInvalid)

      expect(InvoiceItem.count).to eq 0
    end
  end

  context "successful import" do
    it "imports all the invoice itemss and saves them to the database" do
      create(:invoice, id: 1)
      create(:item, id: 234)
      expect{InvoiceItemsImporter.new(good).import}
        .to change{InvoiceItem.count}
        .by(9)
    end
  end
end
