require 'rails_helper'

describe 'Merchants API' do

  let(:date) {"2012-03-27T14:54:02.000Z"}

  context 'find by' do

    let(:merchant_1) { create(:merchant) }
    let(:merchant_2) { create(:merchant) }
    let(:merchant_3) { create(:merchant) }

    it 'id' do
      id = merchant_3.id

      get '/api/v1/merchants/find', params: {id: id}
      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant['name']).to eq merchant_3.name
    end

    it 'name' do
      name = merchant_3.name

      get '/api/v1/merchants/find', params: {name: name}
      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant['id']).to eq merchant_3.id
    end

    it 'updated at' do
      merchant_3.update(updated_at: date)

      get '/api/v1/merchants/find', params: {updated_at: date}
      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant['id']).to eq merchant_3.id
    end

    it 'created at' do
      merchant_3.update(created_at: date)

      get '/api/v1/merchants/find', params: {created_at: date}
      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant['id']).to eq merchant_3.id
    end

    it 'multiple attributes' do
      name = merchant_3.name
      merchant_3.update(created_at: date)
      merchant_3.update(updated_at: date)
      id = merchant_3.id


      get '/api/v1/merchants/find', params: {name: name, id: id, created_at: date, updated_at: date}
      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant['id']).to eq merchant_3.id
    end
  end

  context 'find_all' do

    let!(:merchant_1) {create(:merchant, created_at: date)}
    let!(:merchant_2) {create(:merchant, created_at: date, updated_at: date)}
    let!(:merchant_3) {create(:merchant, updated_at: date)}
    let!(:merchant_4) {create(:merchant)}
    
    it 'name' do
      get '/api/v1/merchants/find_all', params: {name: merchant_1.name}
      merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchants).to be_a Array
      expect(merchants.count).to eq 1
      expect(merchants.first['id']).to eq merchant_1.id
    end

    it 'updated_at' do
      get '/api/v1/merchants/find_all', params: {updated_at: date}
      merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchants).to be_a Array
      expect(merchants.count).to eq 2
      expect(merchants.first['id']).to eq merchant_2.id
      expect(merchants.last['id']).to eq merchant_3.id
    end

    it 'created_at' do
      get '/api/v1/merchants/find_all', params: {created_at: date}
      merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchants).to be_a Array
      expect(merchants.count).to eq 2
      expect(merchants.first['id']).to eq merchant_1.id
      expect(merchants.last['id']).to eq merchant_2.id
    end

    it 'id' do
      get '/api/v1/merchants/find_all', params: {id: merchant_4.id}
      merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchants).to be_a Array
      expect(merchants.count).to eq 1
      expect(merchants.first['id']).to eq merchant_4.id
    end

    it 'multiple attributes' do
      get '/api/v1/merchants/find_all', params: {created_at: date, updated_at: date}
      merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchants).to be_a Array
      expect(merchants.count).to eq 1
    end
  end
end
