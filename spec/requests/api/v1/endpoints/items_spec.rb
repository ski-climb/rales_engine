require 'rails_helper'

describe 'Items API' do
  it 'returns a list of items' do
    item_1, item_2, item_3 = create_list(:item, 3)
    name = item_1.name

    get '/api/v1/items'
    items = JSON.parse(response.body)
    item = items.first

    expect(response).to be_success
    expect(items.count).to eq 3
    expect(item['name']).to eq item_1.name
  end

  it 'returns a single item' do
    create(:item, id: 5)

    get '/api/v1/items/5'
    item = JSON.parse(response.body)

    expect(response).to be_success

    expect(item).to be_a Hash
    expect(item.keys.count).to eq 5
    expect(item).to have_key 'id'
    expect(item).to have_key 'merchant_id'
    expect(item).to have_key 'name'
    expect(item).to have_key 'description'
    expect(item).to have_key 'unit_price'
    expect(item['id']).to be_a Integer
    expect(item['merchant_id']).to be_a Integer
    expect(item['name']).to be_a String
    expect(item['description']).to be_a String
    expect(item['unit_price']).to be_a String
  end

  it 'returns a random item' do
    create_list(:item, 3)

    get '/api/v1/items/random'
    item = JSON.parse(response.body)

    expect(response).to be_success

    expect(item).to be_a Hash
    expect(item.keys.count).to eq 5
    expect(item).to have_key 'id'
    expect(item).to have_key 'name'
    expect(item).to have_key 'description'
    expect(item).to have_key 'unit_price'
    expect(item).to have_key 'merchant_id'
  end
end
