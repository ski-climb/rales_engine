require 'rails_helper'

describe 'Items API' do

  let(:date) {"2012-03-27T14:54:02.000Z"}

  context 'find by' do
    let!(:item_1) { create(:item) }
    let!(:item_2) { create(:item) }
    let!(:item_3) { create(:item) }

    it 'id' do
      id = item_2.id

      get '/api/v1/items/find', params: {id: id}
      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item['id']).to eq item_2.id
      expect(item['name']).to eq item_2.name
    end

    it 'name' do
      name = item_3.name

      get '/api/v1/items/find', params: {name: name}
      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item['id']).to eq item_3.id
      expect(item['name']).to eq item_3.name
    end

    it 'description' do
      description = item_2.description

      get '/api/v1/items/find', params: {description: description}
      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item['id']).to eq item_2.id
      expect(item['description']).to eq item_2.description
    end

    it 'unit_price' do
      unit_price = item_2.unit_price

      get '/api/v1/items/find', params: {unit_price: unit_price}
      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item['id']).to eq item_2.id
      expect(item['unit_price']).to eq item_2.unit_price
    end

    it 'merchant_id' do
      merchant_id = item_2.merchant_id

      get '/api/v1/items/find', params: {merchant_id: merchant_id}
      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item['id']).to eq item_2.id
      expect(item['merchant_id']).to eq item_2.merchant_id
    end

    it 'created_at' do
      item_3.update(created_at: date)

      get '/api/v1/items/find', params: {created_at: date}
      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item['id']).to eq item_3.id
      expect(item['name']).to eq item_3.name
    end

    it 'updated_at' do
      item_2.update(updated_at: date)

      get '/api/v1/items/find', params: {updated_at: date}
      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item['id']).to eq item_2.id
      expect(item['name']).to eq item_2.name
    end

    it 'multiple attributes' do
      item_3.update(created_at: date)
      item_3.update(updated_at: date)

      get '/api/v1/items/find', params: {created_at: date, updated_at: date}
      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item['id']).to eq item_3.id
      expect(item['name']).to eq item_3.name
    end
  end

  context 'find_all' do
    let!(:merchant) { create(:merchant) }
    let!(:merchant_5) { create(:merchant, id: 5) }

    let!(:item_1) { create(:item) }
    let!(:item_2) { create(:item, name: "Hammer", unit_price_in_cents: 12_34, merchant_id: 5) }
    let!(:item_3) { create(:item, name: "Hammer", description: "cute") }
    let!(:item_4) { create(:item, name: "Door", merchant_id: 5, description: "cute", unit_price_in_cents: 12_34, created_at: date, updated_at: date) }
    let!(:item_5) { create(:item, name: "Cat", merchant_id: 5, description: "cute", updated_at: date) }
    let!(:item_6) { create(:item, name: "Cat", merchant_id: 5, unit_price_in_cents: 12_34, created_at: date, updated_at: date) }

    it 'name' do
      get '/api/v1/items/find_all', params: {name: "Hammer"}
      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items).to be_a Array
      expect(items.count).to eq 2
      items.each do |item|
        expect(item['name']).to eq "Hammer"
      end
    end

    it 'description' do
      get '/api/v1/items/find_all', params: {description: "cute"}
      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items).to be_a Array
      expect(items.count).to eq 3
      items.each do |item|
        expect(item['description']).to eq "cute"
      end
    end

    it 'unit_price' do
      unit_price = "12.34"

      get '/api/v1/items/find_all', params: {unit_price: unit_price}
      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items).to be_a Array
      expect(items.count).to eq 3
      items.each do |item|
        expect(item['unit_price']).to eq "12.34"
      end
    end

    it 'merchant_id' do
      get '/api/v1/items/find_all', params: {merchant_id: 5}
      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items).to be_a Array
      expect(items.count).to eq 4
      items.each do |item|
        expect(item['merchant_id']).to eq 5
      end
    end

    it 'created_at' do
      get '/api/v1/items/find_all', params: {created_at: date}
      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items).to be_a Array
      expect(items.count).to eq 2
    end

    it 'updated_at' do
      get '/api/v1/items/find_all', params: {updated_at: date}
      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items).to be_a Array
      expect(items.count).to eq 3
    end

    it 'mutiple attributes' do
      get '/api/v1/items/find_all', params: {name: "Hammer", description: "cute"}
      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items).to be_a Array
      expect(items.count).to eq 1
      expect(items.first['name']).to eq "Hammer"
      expect(items.first['description']).to eq "cute"
    end
  end
end
