require 'rails_helper'

describe 'Items API most items' do
  context 'multiple invoice items' do
    it 'returns items ranked by items sold' do
      first_item = create(:item)
      second_item = create(:item)
      third_item = create(:item)

      invoice = create(:invoice)
      transaction = create(:transaction, invoice: invoice)

      create_list(:invoice_item, 3, item: first_item, quantity: 2, unit_price_in_cents: 500, invoice: invoice)
      create(:invoice_item, item: second_item, quantity: 5, unit_price_in_cents: 100, invoice: invoice)
      create_list(:invoice_item, 4, item: third_item, quantity: 1, unit_price_in_cents: 100, invoice: invoice)

      get "/api/v1/items/most_items?quantity=2"
      items = JSON.parse(response.body)
      item_one = items.first
      item_two = items.last 

      expect(response).to be_success
      expect(items).to be_a Array
      expect(items.count).to eq 2
      expect(item_one['id']).to eq first_item.id
      expect(item_two['id']).to eq second_item.id
    end
  end

  context 'unsuccessful transaction' do
    it 'does not return item' do
      first_item = create(:item)

      invoice = create(:invoice)
      transaction = create(:transaction, invoice: invoice, result: 'failed')

      create_list(:invoice_item, 3, item: first_item, invoice: invoice)

      get "/api/v1/items/most_items?quantity=2"
      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items).to be_a Array
      expect(items.count).to eq 0
    end
  end
end
