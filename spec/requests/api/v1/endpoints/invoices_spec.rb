require 'rails_helper'

describe 'Invoices API' do
  it 'returns a list of invoices' do
    invoice_1, invoice_2, invoice_3 = create_list(:invoice, 3)
    status = invoice_1.status

    get '/api/v1/invoices'
    invoices = JSON.parse(response.body)
    invoice = invoices.first

    expect(response).to be_success
    expect(invoices.count).to eq 3
    expect(invoice['status']).to eq invoice_1.status
  end

  it 'returns a single invoice' do
    create(:invoice, id: 5)

    get '/api/v1/invoices/5'
    invoice = JSON.parse(response.body)

    expect(response).to be_success

    expect(invoice).to be_a Hash
    expect(invoice.keys.count).to eq 4
    expect(invoice).to have_key 'id'
    expect(invoice).to have_key 'customer_id'
    expect(invoice).to have_key 'merchant_id'
    expect(invoice).to have_key 'status'
    expect(invoice['id']).to be_a Integer
    expect(invoice['customer_id']).to be_a Integer
    expect(invoice['merchant_id']).to be_a Integer
    expect(invoice['status']).to be_a String
  end

  it 'returns a random invoice' do
    create_list(:invoice, 3)

    get '/api/v1/invoices/random'
    invoice = JSON.parse(response.body)

    expect(response).to be_success

    expect(invoice).to be_a Hash
    expect(invoice.keys.count).to eq 4
    expect(invoice).to have_key 'id'
    expect(invoice).to have_key 'customer_id'
    expect(invoice).to have_key 'merchant_id'
    expect(invoice).to have_key 'status'
  end
end
