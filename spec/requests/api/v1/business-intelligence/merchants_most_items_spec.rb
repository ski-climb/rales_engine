require 'rails_helper'

describe 'Merchants API most items' do
  context 'multiple invoice items' do
    it 'returns merchants ranked by items sold' do
      merchant_1, merchant_2, merchant_3 = create_list(:merchant, 3)

      merchant_1_invoice = create(:invoice, merchant: merchant_1)
      merchant_2_invoice = create(:invoice, merchant: merchant_2)
      merchant_3_invoice = create(:invoice, merchant: merchant_3)

      transaction = create(:transaction, invoice: merchant_1_invoice)
      transaction = create(:transaction, invoice: merchant_2_invoice)
      transaction = create(:transaction, invoice: merchant_3_invoice)

      create_list(:invoice_item, 3, quantity: 10, invoice: merchant_1_invoice)
      create_list(:invoice_item, 5, quantity: 5, invoice: merchant_2_invoice)
      create_list(:invoice_item, 7, quantity: 3, invoice: merchant_3_invoice)

      get "/api/v1/merchants/most_items?quantity=2"
      merchants = JSON.parse(response.body)
      response_merchant_1 = merchants.first
      response_merchant_2 = merchants.last

      expect(response).to be_success
      expect(merchants).to be_a Array
      expect(merchants.count).to eq 2
      expect(response_merchant_1['id']).to eq merchant_1.id
      expect(response_merchant_2['id']).to eq merchant_2.id
    end
  end

  context 'unsuccessful transaction' do
    it 'does not return merchant' do
      merchant = create(:merchant)

      merchant_invoice = create(:invoice, merchant: merchant)
      transaction = create(:transaction, invoice: merchant_invoice, result: 'failed')
      create(:invoice_item, invoice: merchant_invoice)

      get "/api/v1/merchants/most_items?quantity=2"
      merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchants).to be_a Array
      expect(merchants.count).to eq 0
    end
  end
end
