require 'rails_helper'

describe 'Transactions API' do

  let(:date) {"2012-03-27T14:54:02.000Z"}

  context 'find by' do

    let!(:invoice_1)     { create(:invoice, id: 1) }

    let!(:transaction_1) { create(:transaction, result: 'failed') }
    let!(:transaction_2) { create(:transaction, result: 'failed', invoice_id: 1, id: 50) }
    let!(:transaction_3) { create(:transaction, result: 'success', updated_at: date, created_at: date, credit_card_number: 1) }

    it 'id' do
      get '/api/v1/transactions/find', params: {id: 50}
      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction['id']).to eq transaction_2.id
    end

    it 'result' do
      get '/api/v1/transactions/find', params: {result: 'success'}
      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction['id']).to eq transaction_3.id
    end

    it 'updated at' do
      get '/api/v1/transactions/find', params: {updated_at: date}
      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction['id']).to eq transaction_3.id
    end

    it 'created at' do
      get '/api/v1/transactions/find', params: {created_at: date}
      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction['id']).to eq transaction_3.id
    end

    it 'credit card number' do
      get '/api/v1/transactions/find', params: {credit_card_number: 1}
      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction['id']).to eq transaction_3.id
    end

    it 'invoice id' do
      get '/api/v1/transactions/find', params: {invoice_id: 1}
      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction['id']).to eq transaction_2.id
    end

    it 'multiple attributes' do
      get '/api/v1/transactions/find',
        params: {id: transaction_3.id, created_at: date, updated_at: date, result: 'success', credit_card_number: 1}

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction['id']).to eq transaction_3.id
    end
  end

#   context 'find_all' do

#     let!(:merchant_1) {create(:merchant, created_at: date)}
#     let!(:merchant_2) {create(:merchant, created_at: date, updated_at: date)}
#     let!(:merchant_3) {create(:merchant, updated_at: date)}
#     let!(:merchant_4) {create(:merchant)}
    
#     it 'name' do
#       get '/api/v1/merchants/find_all', params: {name: merchant_1.name}
#       merchants = JSON.parse(response.body)

#       expect(response).to be_success
#       expect(merchants).to be_a Array
#       expect(merchants.count).to eq 1
#       expect(merchants.first['id']).to eq merchant_1.id
#     end

#     it 'updated_at' do
#       get '/api/v1/merchants/find_all', params: {updated_at: date}
#       merchants = JSON.parse(response.body)

#       expect(response).to be_success
#       expect(merchants).to be_a Array
#       expect(merchants.count).to eq 2
#       expect(merchants.first['id']).to eq merchant_2.id
#       expect(merchants.last['id']).to eq merchant_3.id
#     end

#     it 'created_at' do
#       get '/api/v1/merchants/find_all', params: {created_at: date}
#       merchants = JSON.parse(response.body)

#       expect(response).to be_success
#       expect(merchants).to be_a Array
#       expect(merchants.count).to eq 2
#       expect(merchants.first['id']).to eq merchant_1.id
#       expect(merchants.last['id']).to eq merchant_2.id
#     end

#     it 'id' do
#       get '/api/v1/merchants/find_all', params: {id: merchant_4.id}
#       merchants = JSON.parse(response.body)

#       expect(response).to be_success
#       expect(merchants).to be_a Array
#       expect(merchants.count).to eq 1
#       expect(merchants.first['id']).to eq merchant_4.id
#     end

#     it 'multiple attributes' do
#       get '/api/v1/merchants/find_all', params: {created_at: date, updated_at: date}
#       merchants = JSON.parse(response.body)

#       expect(response).to be_success
#       expect(merchants).to be_a Array
#       expect(merchants.count).to eq 1
#     end
#   end
end
