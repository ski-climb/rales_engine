require 'rails_helper'

describe "Customers importer" do
  let(:bad) { './spec/fixtures/bad/customers.csv' }
  let(:good) { './spec/fixtures/good/customers.csv' }

  context "unsuccessful import" do
    it "raises an error" do
      expect{CustomersImporter.new(bad).import}
        .to raise_error(ActiveRecord::RecordInvalid)
    end

    it "does not create any new records to the database" do
      expect(Customer.count).to eq 0
    end
  end

  context "successful import" do
    it "imports all the customers and saves them to the database" do
      expect{CustomersImporter.new(good).import}
        .to change{Customer.count}
        .by(11)
    end
  end
end
