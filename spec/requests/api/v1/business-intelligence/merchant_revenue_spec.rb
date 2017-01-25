require 'rails_helper'

describe 'Merchant API revenue' do
  it 'for one merchant' do
    merchant = create(:merchant)
    successful_invoice = create(:invoice, merchant: merchant)
    failed_invoice = create(:invoice, merchant: merchant)

    successful_transaction = create(:transaction, result: 'success', invoice: successful_invoice)
    failed_transaction = create(:transaction, result: 'failed', invoice: failed_invoice)

    successful_invoice_items = create_list(:invoice_item, 5, invoice: successful_invoice)
    unsuccessful_invoice_items = create_list(:invoice_item, 5, invoice: failed_invoice)


    expected_revenue = successful_invoice_items.reduce(0) do |sum, invoice_item|
      sum += invoice_item.unit_price_in_cents * invoice_item.quantity
    end.to_f / 100

    get "/api/v1/merchants/#{merchant.id}/revenue"
    revenue = JSON.parse(response.body)

    expect(response).to be_success
    expect(revenue).to eq({'revenue' => expected_revenue.to_s})
  end
end