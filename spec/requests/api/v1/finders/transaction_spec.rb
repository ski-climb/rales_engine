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

  context 'find_all' do

    let!(:transaction_1) {create(:transaction, created_at: date, id: 1)}
    let!(:transaction_2) {create(:transaction, created_at: date, updated_at: date)}
    let!(:transaction_3) {create(:transaction, updated_at: date)}
    let!(:transaction_4) {create(:transaction, result: 'failed', credit_card_number: 2)}
    let!(:transaction_5) {create(:transaction, result: 'failed', credit_card_number: 2)}
    
    it 'id' do
      get '/api/v1/transactions/find_all', params: {id: 1}
      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions).to be_a Array
      expect(transactions.count).to eq 1
      expect(transactions.first['id']).to eq transaction_1.id
    end

    it 'result' do
      get '/api/v1/transactions/find_all', params: {result: 'failed'}
      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions).to be_a Array
      expect(transactions.count).to eq 2
      expect(transactions.first['id']).to eq transaction_4.id
      expect(transactions.last['id']).to eq transaction_5.id
    end

    it 'created at' do
      get '/api/v1/transactions/find_all', params: {created_at: date}
      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions).to be_a Array
      expect(transactions.count).to eq 2
      expect(transactions.first['id']).to eq transaction_1.id
      expect(transactions.last['id']).to eq transaction_2.id
    end

    it 'updated at' do
      get '/api/v1/transactions/find_all', params: {updated_at: date}
      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions).to be_a Array
      expect(transactions.count).to eq 2
      expect(transactions.first['id']).to eq transaction_2.id
      expect(transactions.last['id']).to eq transaction_3.id
    end

    it 'credit card number' do
      get '/api/v1/transactions/find_all', params: {credit_card_number: 2}
      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions).to be_a Array
      expect(transactions.count).to eq 2
      expect(transactions.first['id']).to eq transaction_4.id
      expect(transactions.last['id']).to eq transaction_5.id
    end

    it 'invoice id' do
      get '/api/v1/transactions/find_all', params: {invoice_id: transaction_1.invoice_id}
      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions).to be_a Array
      expect(transactions.count).to eq 1
      expect(transactions.first['id']).to eq transaction_1.id
    end

    it 'multiple attributes' do
      get '/api/v1/transactions/find_all',
        params: {created_at: date, updated_at: date}
      
      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions).to be_a Array
      expect(transactions.count).to eq 1
      expect(transactions.first['id']).to eq transaction_2.id
    end
  end
end
