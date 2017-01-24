require 'rails_helper'

describe 'Customers API' do
  it 'returns a list of customers' do
    customer_1, customer_2, customer_3 = create_list(:customer, 3)
    name = customer_1.first_name

    get '/api/v1/customers'
    customers = JSON.parse(response.body)
    customer = customers.first

    expect(response).to be_success
    expect(customers.count).to eq 3
    expect(customer['first_name']).to eq name
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
