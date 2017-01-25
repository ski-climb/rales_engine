require 'rails_helper'

describe 'Transactions API' do
  it 'returns a list of transactions' do
    transaction_1, transaction_2, transaction_3 = create_list(:transaction, 3)

    get '/api/v1/transactions'
    transactions = JSON.parse(response.body)
    transaction = transactions.first

    expect(response).to be_success
    expect(transactions.count).to eq 3
    expect(transaction['result']).to eq 'success'
  end

  it 'returns a single transaction' do
    create(:transaction, id: 5)

    get '/api/v1/transactions/5'
    transaction = JSON.parse(response.body)

    expect(response).to be_success

    expect(transaction).to be_a Hash
    expect(transaction.keys.count).to eq 4

    expect(transaction).to have_key 'id'
    expect(transaction).to have_key 'credit_card_number'
    expect(transaction).to have_key 'result'
    expect(transaction).to have_key 'invoice_id'

    expect(transaction['credit_card_number']).to be_a String
    expect(transaction['id']).to be_a Integer
    expect(transaction['result']).to be_a String
    expect(transaction['invoice_id']).to be_a Integer
  end

  it 'returns a random transaction' do
    create_list(:transaction, 3)

    get '/api/v1/transactions/random'
    transaction = JSON.parse(response.body)

    expect(response).to be_success

    expect(transaction).to be_a Hash
    expect(transaction.keys.count).to eq 4
    expect(transaction).to have_key 'result'
  end
end
