require 'rails_helper'

describe 'Items API most items' do
  context 'no quantity specificied' do
    it 'returns top item' do
      top_item = create(:item)
      other_item = create(:item)

      create_list(:invoice_item, 3, item: top_item, quantity: 2)
      create_list(:invoice_item, 4, item: other_item, quantity: 1)

      get '/api/v1/items/most_items'
      items = JSON.parse(response.body)
      item = items.first

      expect(response).to be_success
      expect(items).to be_a Array
      expect(items.count).to eq 1
      expect(item['id']).to eq top_item.id
    end
  end

  context 'quantity specified' do
    it 'returns quantity of top items' do
      first_item = create(:item)
      second_item = create(:item)
      third_item = create(:item)

      create_list(:invoice_item, 3, item: first_item, quantity: 2)
      create_list(:invoice_item, 4, item: second_item, quantity: 1)
      create_list(:invoice_item, 4, item: third_item, quantity: 1)

      get '/api/v1/items/most_items?quantity=2'
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
end