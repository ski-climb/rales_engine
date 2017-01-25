require 'rails_helper'

describe 'Transactions API relationship' do

  it 'invoice' do
    transaction = create(:transaction)
    invoice = transaction.invoice

    get "/api/v1/transactions/#{transaction.id}/invoice"
    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice).to be_a Hash
    expect(invoice_id).to eq invoice['id']
    expect(invoice.merchant_id).to eq invoice['merchant_id']
    expect(invoice.customer).to eq invoice['customer_id']
    expect(invoice.keys.count).to eq 3
  end
end