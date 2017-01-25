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
    end

    get "/api/v1/merchants/#{merchant.id}/revenue"
    revenue = JSON.parse(response.body)

    expect(response).to be_success
    expect(revenue).to eq({'revenue' => (expected_revenue.to_f / 100).to_s})
  end

  it 'for one merchant by date' do
    date_1 = '2012-03-16 11:55:05'
    date_2 = '2012-03-07 10:54:55'

    merchant = create(:merchant)

    invoice_on_date_1 = create(:invoice, merchant: merchant)
    invoice_on_date_2 = create(:invoice, merchant: merchant)

    transaction_on_date_1 = create(:transaction, invoice: invoice_on_date_1, created_at: date_1)
    transaction_on_date_2 = create(:transaction, invoice: invoice_on_date_2, created_at: date_2)

    invoice_items_on_date_1 = create_list(:invoice_item, 5, invoice: invoice_on_date_1)
    invoice_items_on_date_2 = create_list(:invoice_item, 5, invoice: invoice_on_date_2)


    expected_revenue = invoice_items_on_date_1.reduce(0) do |sum, invoice_item|
      sum += invoice_item.unit_price_in_cents * invoice_item.quantity
    end

    get "/api/v1/merchants/#{merchant.id}/revenue/?date=#{date_1}"
    revenue = JSON.parse(response.body)

    expect(response).to be_success
    expect(revenue).to eq({'revenue' => (expected_revenue.to_f / 100).to_s})
  end
end