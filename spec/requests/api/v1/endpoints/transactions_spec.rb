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

  # it 'returns a single merchant' do
  #   create(:merchant, id: 5)

  #   get '/api/v1/merchants/5'
  #   merchant = JSON.parse(response.body)

  #   expect(response).to be_success

  #   expect(merchant).to be_a Hash
  #   expect(merchant.keys.count).to eq 2
  #   expect(merchant).to have_key 'id'
  #   expect(merchant).to have_key 'name'
  #   expect(merchant['name']).to be_a String
  #   expect(merchant['id']).to be_a Integer
  # end

  # it 'returns a random merchant' do
  #   create_list(:merchant, 3)

  #   get '/api/v1/merchants/random'
  #   merchant = JSON.parse(response.body)

  #   expect(response).to be_success

  #   expect(merchant).to be_a Hash
  #   expect(merchant.keys.count).to eq 2
  #   expect(merchant).to have_key 'id'
  #   expect(merchant).to have_key 'name'
  # end
end
