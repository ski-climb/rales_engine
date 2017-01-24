require 'rails_helper'

describe 'Customers Importer' do
  let(:bad) { './spec/fixtures/bad/customers.csv' }
  let(:good) { './spec/fixtures/good/customers.csv' }

  context 'unsuccessful import' do
    it 'raises an error' do
      expect{CustomersImporter.new(bad).import}
        .to raise_error(ActiveRecord::RecordInvalid)
      
      expect(Customer.count).to eq 0
    end
  end

  context 'successful import' do
    it 'changes count' do
      expect{CustomersImporter.new(good).import}
        .to change{Customer.count}.by 3
    end
  end
end
