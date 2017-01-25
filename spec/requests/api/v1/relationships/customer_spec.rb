require 'rails_helper'

describe 'Customer API relationships' do

  it 'invoices' do
    customer = create(:customer)
    invoices = create_list(:invoice, 5, customer: customer)
    invoice = invoices.first
 
    get "/api/v1/customers/#{customer.id}/invoices"
    response_invoices = JSON.parse(response.body)
    response_invoice = response_invoices.first
  
    expect(response).to be_success
    expect(response_invoices).to be_a Array
    expect(response_invoices.count).to eq 5
    expect(response_invoice['id']).to eq invoice.id
    expect(response_invoice['merchant_id']).to eq invoice.merchant_id
    expect(response_invoice['customer_id']).to eq invoice.customer_id
  end

  it 'transactions' do
    customer = create(:customer)
    invoice_1 = create(:invoice, customer: customer)
    invoice_2 = create(:invoice, customer: customer)
    transaction_1, transaction_2 = create_list(:transaction, 2, invoice: invoice_1)
    transaction_1, transaction_2 = create_list(:transaction, 2, invoice: invoice_2)

    get "/api/v1/customers/#{customer.id}/transactions"
    transactions = JSON.parse(response.body)
    transaction = transactions.first

    expect(response).to be_success
    expect(transactions).to be_a Array
    expect(transactions.count).to eq 4
    expect(transaction['result']).to eq 'success'
  end
end
