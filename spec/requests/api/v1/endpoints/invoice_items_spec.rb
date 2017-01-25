require 'rails_helper'

describe 'InvoiceItems API' do
  it 'returns a list of invoice_items' do
    invoice_item_1, invoice_item_2, invoice_item_3 = create_list(:invoice_item, 3)
    invoice_id = invoice_item_1.invoice_id
    item_id = invoice_item_1.item_id

    get '/api/v1/invoice_items'
    invoice_items = JSON.parse(response.body)
    invoice_item = invoice_items.first

    expect(response).to be_success
    expect(invoice_items.count).to eq 3
    expect(invoice_item['invoice_id']).to eq invoice_item_1.invoice_id
    expect(invoice_item['item_id']).to eq invoice_item_1.item_id
  end

  it 'returns a single invoice_item' do
    create(:invoice_item, id: 5)

    get '/api/v1/invoice_items/5'
    invoice_item = JSON.parse(response.body)

    expect(response).to be_success

    expect(invoice_item).to be_a Hash
    expect(invoice_item.keys.count).to eq 5
    expect(invoice_item).to have_key 'id'
    expect(invoice_item).to have_key 'invoice_id'
    expect(invoice_item).to have_key 'item_id'
    expect(invoice_item).to have_key 'quantity'
    expect(invoice_item).to have_key 'unit_price'
    expect(invoice_item['id']).to be_a Integer
    expect(invoice_item['invoice_id']).to be_a Integer
    expect(invoice_item['item_id']).to be_a Integer
    expect(invoice_item['quantity']).to be_a Integer
    expect(invoice_item['unit_price']).to be_a String
  end

  it 'returns a random invoice_item' do
    create_list(:invoice_item, 3)

    get '/api/v1/invoice_items/random'
    invoice_item = JSON.parse(response.body)

    expect(response).to be_success

    expect(invoice_item).to be_a Hash
    expect(invoice_item.keys.count).to eq 5
    expect(invoice_item).to have_key 'id'
    expect(invoice_item).to have_key 'invoice_id'
    expect(invoice_item).to have_key 'item_id'
    expect(invoice_item).to have_key 'quantity'
    expect(invoice_item).to have_key 'unit_price'
  end
end
