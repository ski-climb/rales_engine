require 'rails_helper'

describe 'Items Importer' do
  let(:bad) { './spec/fixtures/bad/items.csv' }
  let(:good) { './spec/fixtures/good/items.csv' }

  context 'unsuccessful import' do
    it 'raises an error' do
      expect{ItemsImporter.new(bad).import}
        .to raise_error(ActiveRecord::RecordInvalid)
      
      expect(Item.count).to eq 0
    end
  end

  context 'successful import' do
    it 'changes count' do
      create(:merchant, id: 1)
      expect{ItemsImporter.new(good).import}
        .to change{Item.count}.by 3
    end
  end
end
