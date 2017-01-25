require 'rails_helper'

describe 'Invoices API' do

  let(:date) {"2012-03-27T14:54:02.000Z"}

  context 'find by' do
    let!(:invoice_1) { create(:invoice) }
    let!(:invoice_2) { create(:invoice) }
    let!(:invoice_3) { create(:invoice) }

    it 'id' do
      id = invoice_2.id

      get '/api/v1/invoices/find', params: {id: id}
      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice['id']).to eq invoice_2.id
      expect(invoice['customer_id']).to eq invoice_2.customer_id
      expect(invoice['status']).to eq invoice_2.status
    end

    it 'status' do
      status = "shipped"

      get '/api/v1/invoices/find', params: {status: status}
      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice['id']).to eq invoice_1.id
      expect(invoice['status']).to eq invoice_1.status
      expect(invoice['customer_id']).to eq invoice_1.customer_id
    end

    it 'customer_id' do
      customer_id = invoice_2.customer_id

      get '/api/v1/invoices/find', params: {customer_id: customer_id}
      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice['id']).to eq invoice_2.id
      expect(invoice['customer_id']).to eq invoice_2.customer_id
    end

    it 'merchant_id' do
      merchant_id = invoice_2.merchant_id

      get '/api/v1/invoices/find', params: {merchant_id: merchant_id}
      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice['id']).to eq invoice_2.id
      expect(invoice['merchant_id']).to eq invoice_2.merchant_id
    end

    it 'created_at' do
      invoice_3.update(created_at: date)

      get '/api/v1/invoices/find', params: {created_at: date}
      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice['id']).to eq invoice_3.id
      expect(invoice['customer_id']).to eq invoice_3.customer_id
    end

    it 'updated_at' do
      invoice_2.update(updated_at: date)

      get '/api/v1/invoices/find', params: {updated_at: date}
      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice['id']).to eq invoice_2.id
      expect(invoice['customer_id']).to eq invoice_2.customer_id
    end

    it 'multiple attributes' do
      invoice_3.update(created_at: date)
      invoice_3.update(updated_at: date)

      get '/api/v1/invoices/find', params: {created_at: date, updated_at: date}
      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice['id']).to eq invoice_3.id
      expect(invoice['customer_id']).to eq invoice_3.customer_id
    end
  end

  context 'find_all' do
    let!(:customer) { create(:customer) }
    let!(:customer_4) { create(:customer, id: 4) }
    let!(:merchant) { create(:merchant) }
    let!(:merchant_5) { create(:merchant, id: 5) }

    let!(:invoice_1) { create(:invoice) }
    let!(:invoice_2) { create(:invoice, merchant_id: 5, customer_id: 4) }
    let!(:invoice_3) { create(:invoice, merchant_id: 5, created_at: date) }
    let!(:invoice_4) { create(:invoice, customer_id: 4, updated_at: date) }
    let!(:invoice_5) { create(:invoice, customer_id: 4, created_at: date) }
    let!(:invoice_6) { create(:invoice, created_at: date, updated_at: date) }

    it 'status' do
      get '/api/v1/invoices/find_all', params: {status: "shipped"}
      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices).to be_a Array
      expect(invoices.count).to eq 6
      invoices.each do |invoice|
        expect(invoice['status']).to eq "shipped"
      end
    end

    it 'customer_id' do
      get '/api/v1/invoices/find_all', params: {customer_id: 4}
      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices).to be_a Array
      expect(invoices.count).to eq 3
      invoices.each do |invoice|
        expect(invoice['customer_id']).to eq 4
      end
    end

    it 'merchant_id' do
      get '/api/v1/invoices/find_all', params: {merchant_id: 5}
      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices).to be_a Array
      expect(invoices.count).to eq 2
      invoices.each do |invoice|
        expect(invoice['merchant_id']).to eq 5
      end
    end

    it 'created_at' do
      get '/api/v1/invoices/find_all', params: {created_at: date}
      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices).to be_a Array
      expect(invoices.count).to eq 3
    end

    it 'updated_at' do
      get '/api/v1/invoices/find_all', params: {updated_at: date}
      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices).to be_a Array
      expect(invoices.count).to eq 2
    end

    it 'mutiple attributes' do
      get '/api/v1/invoices/find_all', params: {status: "shipped", customer_id: 4}
      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices).to be_a Array
      expect(invoices.count).to eq 3
    end
  end
end
