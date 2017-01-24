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

  it 'returns a single customer' do
    create(:customer, id: 5)

    get '/api/v1/customers/5'
    customer = JSON.parse(response.body)

    expect(response).to be_success

    expect(customer).to be_a Hash
    expect(customer.keys.count).to eq 3
    expect(customer).to have_key 'id'
    expect(customer).to have_key 'first_name'
    expect(customer).to have_key 'last_name'
    expect(customer['first_name']).to be_a String
    expect(customer['last_name']).to be_a String
    expect(customer['id']).to be_a Integer
  end

  it 'returns a random customer' do
    create_list(:customer, 3)

    get '/api/v1/customers/random'
    customer = JSON.parse(response.body)

    expect(response).to be_success

    expect(customer).to be_a Hash
    expect(customer.keys.count).to eq 3
    expect(customer).to have_key 'id'
    expect(customer).to have_key 'first_name'
    expect(customer).to have_key 'last_name'
  end
end
