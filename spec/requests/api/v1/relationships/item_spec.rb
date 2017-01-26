require 'rails_helper'

describe 'Items API relationship' do
  let!(:merchant)      { create(:merchant) }
  let!(:item)          { create(:item, merchant: merchant) }
  let!(:invoice_items) { create_list(:invoice_item, 8, item: item, quantity: 9) }

  it 'invoice_items' do
    get "/api/v1/items/#{item.id}/invoice_items"
    response_invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(response_invoice_items).to be_an Array
    expect(response_invoice_items.first).to be_a Hash
    response_invoice_items.each do |invoice_item|
      expect(invoice_item['quantity']).to eq 9
    end
  end

  it 'merchant' do
    get "/api/v1/items/#{item.id}/merchant"
    response_merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(response_merchant).to be_a Hash
    expect(response_merchant['id']).to eq merchant.id
    expect(response_merchant['name']).to eq merchant.name
  end
end
