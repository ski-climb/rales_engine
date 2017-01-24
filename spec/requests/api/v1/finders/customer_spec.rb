require 'rails_helper'

describe 'Customers API' do

  let(:date) {"2012-03-27T14:54:02.000Z"}

  context 'find by' do

    let(:customer_1) { create(:customer) }
    let(:customer_2) { create(:customer) }
    let(:customer_3) { create(:customer) }

    it 'id' do
      id = customer_3.id

      get '/api/v1/customers/find', params: {id: id}
      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer['first_name']).to eq customer_3.first_name
    end

    it 'first_name' do
      first_name = customer_3.first_name

      get '/api/v1/customers/find', params: {first_name: first_name}
      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer['id']).to eq customer_3.id
    end

    it 'last_name' do
      last_name = customer_3.last_name

      get '/api/v1/customers/find', params: {last_name: last_name}
      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer['id']).to eq customer_3.id
    end

    it 'updated at' do
      customer_3.update(updated_at: date)

      get '/api/v1/customers/find', params: {updated_at: date}
      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer['id']).to eq customer_3.id
    end

    it 'created at' do
      customer_3.update(created_at: date)

      get '/api/v1/customers/find', params: {created_at: date}
      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer['id']).to eq customer_3.id
    end

    it 'multiple attributes' do
      first_name = customer_3.first_name
      last_name = customer_3.last_name
      customer_3.update(created_at: date)
      customer_3.update(updated_at: date)
      id = customer_3.id

      get '/api/v1/customers/find',
      params: {first_name: first_name, last_name: last_name, id: id,created_at: date, updated_at: date}

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer['id']).to eq customer_3.id
    end
  end

  # context 'find_all' do

  #   let!(:customer_1) {create(:customer, first_name: 'Mike', created_at: date)}
  #   let!(:customer_2) {create(:customer, first_name: 'Mike', created_at: date, updated_at: date)}
  #   let!(:customer_3) {create(:customer, last_name: 'Targaryen', updated_at: date)}
  #   let!(:customer_4) {create(:customer, last_name: 'Targaryen')}
    
  #   it 'first_name' do
  #     get '/api/v1/customers/find_all', params: {first_name: customer_1.first_name}
  #     customers = JSON.parse(response.body)

  #     expect(response).to be_success
  #     expect(customers).to be_a Array
  #     expect(customers.count).to eq 1
  #     expect(customers.first['id']).to eq customer_1.id
  #   end

  #   it 'last_name' do
  #     get '/api/v1/customers/find_all', params: {last_name: customer_1.last_name}
  #     customers = JSON.parse(response.body)

  #     expect(response).to be_success
  #     expect(customers).to be_a Array
  #     expect(customers.count).to eq 1
  #     expect(customers.first['id']).to eq customer_1.id
  #   end

  #   it 'updated_at' do
  #     get '/api/v1/customers/find_all', params: {updated_at: date}
  #     customers = JSON.parse(response.body)

  #     expect(response).to be_success
  #     expect(customers).to be_a Array
  #     expect(customers.count).to eq 2
  #     expect(customers.first['id']).to eq customer_2.id
  #     expect(customers.last['id']).to eq customer_3.id
  #   end

  #   it 'created_at' do
  #     get '/api/v1/customers/find_all', params: {created_at: date}
  #     customers = JSON.parse(response.body)

  #     expect(response).to be_success
  #     expect(customers).to be_a Array
  #     expect(customers.count).to eq 2
  #     expect(customers.first['id']).to eq customer_1.id
  #     expect(customers.last['id']).to eq customer_2.id
  #   end

  #   it 'id' do
  #     get '/api/v1/customers/find_all', params: {id: customer_4.id}
  #     customers = JSON.parse(response.body)

  #     expect(response).to be_success
  #     expect(customers).to be_a Array
  #     expect(customers.count).to eq 1
  #     expect(customers.first['id']).to eq customer_4.id
  #   end

  #   it 'multiple attributes' do
  #     get '/api/v1/customers/find_all', params: {created_at: date, updated_at: date}
  #     customers = JSON.parse(response.body)

  #     expect(response).to be_success
  #     expect(customers).to be_a Array
  #     expect(customers.count).to eq 1
  #   end
  # end
end
