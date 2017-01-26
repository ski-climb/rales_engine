require 'rails_helper'

describe 'Items API most revenue endpoint' do
  context 'smaller quantity but higher revenue' do
    it 'returns the items ranked by revenue' do
      higher_quantity_item = create(:item)
      higher_revenue_item = create(:item)
      invoice = create(:invoice)
      transaction = create(:transaction, invoice: invoice)
      higher_revenue_invoice_item = create(:invoice_item, invoice: invoice, item: higher_revenue_item, quantity: 2, unit_price_in_cents: 5_00)
      higher_quantity_invoice_item = create(:invoice_item, invoice: invoice, item: higher_quantity_item, quantity: 3, unit_price_in_cents: 1_00)

      get '/api/v1/items/most_revenue?quantity=2'
      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items).to be_an Array
      expect(items.count).to be 2
      expect(items.first['id']).to eq higher_revenue_item.id
      expect(items.last['id']).to eq higher_quantity_item.id
    end
  end

  context 'successful and unsuccessful transations' do
    it 'returns items ranked by revenue for successful transactions' do
      successful_item = create(:item)
      unsuccessful_item = create(:item)
      successful_invoice = create(:invoice)
      unsuccessful_invoice = create(:invoice)
      successful_transaction = create(:transaction, invoice: successful_invoice)
      unsuccessful_transaction = create(:transaction, invoice: unsuccessful_invoice, result: "failed")
      successful_invoice_item = create(:invoice_item, invoice: successful_invoice, item: successful_item, quantity: 2, unit_price_in_cents: 1_00)
      unsuccessful_invoice_item = create(:invoice_item, invoice: unsuccessful_invoice, item: unsuccessful_item, quantity: 3, unit_price_in_cents: 1_00)

      get '/api/v1/items/most_revenue?quantity=1'
      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items).to be_an Array
      expect(items.count).to be 1
      expect(items.first['id']).to eq successful_item.id
    end
  end

  context 'summing revenue across multiple invoices' do
    it 'returns items ranked by revenue' do 
      item_1, item_2, item_3 = create_list(:item, 3)
      invoice_1, invoice_2 = create_list(:invoice, 2)
      transaction_1 = create(:transaction, result: "success", invoice: invoice_1)
      transaction_2 = create(:transaction, result: "success", invoice: invoice_2)

      invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 2, unit_price_in_cents: 1_00)
      invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice_1, quantity: 3, unit_price_in_cents: 1_00)

      invoice_item_3 = create(:invoice_item, item: item_1, invoice: invoice_2, quantity: 2, unit_price_in_cents: 1_00)
      invoice_item_4 = create(:invoice_item, item: item_3, invoice: invoice_2, quantity: 1, unit_price_in_cents: 1_00)

      get '/api/v1/items/most_revenue?quantity=2'
      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items).to be_an Array
      expect(items.count).to be 2
      expect(items.first['id']).to eq item_1.id
      expect(items.last['id']).to eq item_2.id
    end
  end
end
