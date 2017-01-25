require 'rails_helper'

describe 'Transactions API relationship' do

  it 'invoice' do
    transaction = create(:transaction)
    invoice = transaction.invoice

    get "/api/v1/transactions/#{transaction.id}/invoice"
    response_invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(response_invoice).to be_a Hash
    expect(response_invoice['id']).to eq invoice.id
    expect(response_invoice['merchant_id']).to eq invoice.merchant_id
    expect(response_invoice['customer_id']).to eq invoice.customer_id
  end
end
