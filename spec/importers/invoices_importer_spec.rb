require 'rails_helper'

describe "Invoices importer" do
  let(:bad) { './spec/fixtures/bad/invoices.csv' }
  let(:good) { './spec/fixtures/good/invoices.csv' }

  context "unsuccessful import" do
    it "raises an error and does not save any invoices to the database" do
      expect{InvoicesImporter.new(bad).import}
        .to raise_error(ActiveRecord::RecordInvalid)

      expect(Invoice.count).to eq 0
    end
  end

  context "successful import" do
    it "imports all the invoices and saves them to the database" do
      create(:customer, id: 1)
      create(:merchant, id: 22)
      expect{InvoicesImporter.new(good).import}
        .to change{Invoice.count}
        .by(8)
    end
  end
end
