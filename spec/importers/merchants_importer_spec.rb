require 'rails_helper'

describe 'Merchants Importer' do
  it '#import' do
    file = './spec/fixtures/merchants.csv'

    expect {
      MerchantsImporter.new(file).import
    }.to change { Merchant.count }.by 3
  end
end

