require 'rails_helper'

describe 'InvoiceItems API relationship' do
  let(:invoice_item) { create(:invoice_item) }

  it 'invoice' do
    invoice = invoice_item.invoice

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"
    response_invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(response_invoice).to be_a Hash
    expect(response_invoice['id']).to eq invoice.id
    expect(response_invoice['merchant_id']).to eq invoice.merchant_id
    expect(response_invoice['customer_id']).to eq invoice.customer_id
  end

  it 'item' do
    item = invoice_item.item

    get "/api/v1/invoice_items/#{invoice_item.id}/item"
    response_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(response_item).to be_a Hash
    expect(response_item['id']).to eq item.id
    expect(response_item['description']).to eq item.description
  end
end
