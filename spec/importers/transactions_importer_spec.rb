require 'rails_helper'

describe 'Transactions Importer' do
  let(:bad) { './spec/fixtures/bad/transactions.csv' }
  let(:good) { './spec/fixtures/good/transactions.csv' }

  context 'unsuccessful import' do
    it 'raises an error' do
      expect{TransactionsImporter.new(bad).import}
        .to raise_error(ActiveRecord::RecordInvalid)
      
      expect(Transaction.count).to eq 0
    end
  end

  context 'successful import' do
    it 'changes count' do
      expect{TransactionsImporter.new(good).import}
        .to change{Transaction.count}.by 3
    end
  end
end
