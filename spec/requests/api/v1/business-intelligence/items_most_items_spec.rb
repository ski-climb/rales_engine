require 'rails_helper'

describe 'Items API most items' do
  it 'returns top items ranked by revenue' do
    quantity = 2

    first_item = create(:item)
    second_item = create(:item)
    third_item = create(:item)

    create_list(:invoice_item, 3, item: first_item, quantity: 1, unit_price_in_cents: 500)
    create(:invoice_item, item: second_item, quantity: 5, unit_price_in_cents: 100)
    create_list(:invoice_item, 4, item: third_item, quantity: 1, unit_price_in_cents: 100)

    get "/api/v1/items/most_items?quantity=#{quantity}"
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
