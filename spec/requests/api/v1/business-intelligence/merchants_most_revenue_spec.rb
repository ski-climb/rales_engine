require 'rails_helper'

describe 'Merchant API most revenue endpoint' do
  let!(:merchant_1) { create(:merchant) }
  let!(:merchant_2) { create(:merchant) }
  let!(:invoice_1) { create(:invoice, merchant: merchant_1) }
  let!(:invoice_2) { create(:invoice, merchant: merchant_2) }
  let!(:transaction_1) { create(:transaction, invoice: invoice_1, result: "success") }
  let!(:transaction_2) { create(:transaction, invoice: invoice_2, result: "success") }
  let!(:invoice_item_1) { create(:invoice_item, invoice: invoice_1, quantity: 1, unit_price_in_cents: 1_000_00) }
  let!(:invoice_items) { create_list(:invoice_item, 50, invoice: invoice_2, quantity: 10, unit_price_in_cents: 1_00) }

  context 'smaller quantity but higher revenue' do
    it 'returns the merchants ranked by total revenue' do
      get '/api/v1/merchants/most_revenue?quantity=2'
      merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchants).to be_an Array
      expect(merchants.count).to be 2
      expect(merchants.first['id']).to eq merchant_1.id
      expect(merchants.first['name']).to eq merchant_1.name
      expect(merchants.last['id']).to eq merchant_2.id
      expect(merchants.last['name']).to eq merchant_2.name
    end
  end

  context 'successful and unsuccessful transations' do
    let!(:invoice_3) { create(:invoice, merchant: merchant_1) }
    let!(:transaction_3) { create(:transaction, invoice: invoice_3, result: "failed") }
    let!(:invoice_item_2) { create(:invoice_item, invoice: invoice_2, quantity: 10, unit_price_in_cents: 5_000_00) }
    let!(:invoice_item_3) { create(:invoice_item, invoice: invoice_3, quantity: 1, unit_price_in_cents: 2_000_00) }

    it 'returns the merchants ranked by total revenue' do

      get '/api/v1/merchants/most_revenue?quantity=2'
      merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchants).to be_an Array
      expect(merchants.count).to be 2
      expect(merchants.first['id']).to eq merchant_2.id
      expect(merchants.first['name']).to eq merchant_2.name
      expect(merchants.last['id']).to eq merchant_1.id
      expect(merchants.last['name']).to eq merchant_1.name
    end
  end
end
