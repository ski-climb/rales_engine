require 'rails_helper'

describe 'Merchants API most items' do
  it 'returns top merchants ranked by total items sold' do
    quantity = 2

    first_merchant = create(:merchant)
    second_merchant = create(:merchant)
    third_merchant = create(:merchant)

    first_merchant_invoice = create(:invoice, merchant: first_merchant)
    second_merchant_invoice = create(:invoice, merchant: second_merchant)
    third_merchant_invoice = create(:invoice, merchant: third_merchant)

    create_list(:invoice_item, 3, quantity: 5, invoice: first_merchant_invoice)
    create_list(:invoice_item, 3, quantity: 4, invoice: second_merchant_invoice)
    create_list(:invoice_item, 3, quantity: 3, invoice: third_merchant_invoice)

    get "/api/v1/merchants/most_items?quantity=#{quantity}"
    merchants = JSON.parse(response.body)
    first_merchant = merchants.first
    secone_merchant = merchants.last

    expect(response).to be_success
    expect(merchants).to be_a Array
    expect(merchants.count).to eq 2
    expect(first_merchant['id']).to eq first_merchant.id
    expect(second_merchant['id']).to eq second_merchant.id
  end
end
