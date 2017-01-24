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
end
