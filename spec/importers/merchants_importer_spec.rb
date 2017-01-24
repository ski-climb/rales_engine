require 'rails_helper'

describe 'Merchants Importer' do
  let(:bad) { './spec/fixtures/bad/merchants.csv' }
  let(:good) { './spec/fixtures/good/merchants.csv' }

  context 'unsuccessful import' do
    it 'raises an error' do
      expect{MerchantsImporter.new(bad).import}
        .to raise_error(ActiveRecord::RecordInvalid)
      
      expect(Merchant.count).to eq 0
    end
  end

  context 'successful import' do
    it 'changes count' do
      expect{MerchantsImporter.new(good).import}
        .to change{Merchant.count}.by 3
    end
  end
end
