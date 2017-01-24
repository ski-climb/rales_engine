require 'rails_helper'

describe "Customers importer" do
  let(:bad) { './spec/fixtures/bad/customers.csv' }
  let(:good) { './spec/fixtures/good/customers.csv' }

  context "unsuccessful import" do
    it "raises an error and does not save any customers to the database" do
      expect{CustomersImporter.new(bad).import}
        .to raise_error(ActiveRecord::RecordInvalid)

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
