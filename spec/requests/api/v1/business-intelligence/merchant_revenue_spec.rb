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
    date_1 = '2012-03-16 4:55:05'
    date_2 = '2012-03-07 10:54:55'

    merchant = create(:merchant)

    invoice_on_date_1 = create(:invoice, merchant: merchant, created_at: date_1)
    invoice_on_date_2 = create(:invoice, merchant: merchant, created_at: date_2)

    transaction_on_date_1 = create(:transaction, invoice: invoice_on_date_1)
    transaction_on_date_2 = create(:transaction, invoice: invoice_on_date_2)

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

  context 'for all merchants at one infinitesimal instant in time, but not a day' do
    let!(:sliver_of_time) { "2012-03-16 11:55:05" }
    let!(:another_time)   { "2012-03-16 11:55:06" }

    let!(:invoice_1_in_that_moment) { create(:invoice, created_at: sliver_of_time) }
    let!(:invoice_2_in_that_moment) { create(:invoice, created_at: sliver_of_time) }
    let!(:invoice_3_in_that_moment) { create(:invoice, created_at: sliver_of_time) }
    let!(:invoice_NOT_in_that_moment) { create(:invoice, created_at: another_time) }

    let!(:successful_transaction_1) { create(:transaction, invoice: invoice_1_in_that_moment, result: "success") }
    let!(:successful_transaction_2) { create(:transaction, invoice: invoice_2_in_that_moment, result: "success") }
    let!(:UNsuccessful_transaction) { create(:transaction, invoice: invoice_3_in_that_moment, result: "failed") }
    let!(:not_in_the_moment_successful_transaction) { create(:transaction, invoice: invoice_NOT_in_that_moment, result: "success") }

    let!(:included_invoice_items_1) { create_list(:invoice_item, 3, invoice: invoice_1_in_that_moment, unit_price_in_cents: 11_11, quantity: 2) }
    let!(:included_invoice_items_2) { create_list(:invoice_item, 2, invoice: invoice_2_in_that_moment, unit_price_in_cents: 21_12, quantity: 1) }
    let!(:NOT_included_invoice_items) { create_list(:invoice_item, 3, invoice: invoice_NOT_in_that_moment, unit_price_in_cents: 12_34) }

    it 'returns the total revenue' do
      expected_revenue = 66_66 + 42_24
      get "/api/v1/merchants/revenue?date=#{sliver_of_time}"

      expect(response).to be_success
      expect(Merchant.revenue_by_day(sliver_of_time)).to eq expected_revenue
    end
  end
end
