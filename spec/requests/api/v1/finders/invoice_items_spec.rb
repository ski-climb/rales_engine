require 'rails_helper'

describe 'invoice_items API' do

  let(:date) {"2012-03-27T14:54:02.000Z"}

  context 'find by' do
    let!(:invoice_item_1) { create(:invoice_item) }
    let!(:invoice_item_2) { create(:invoice_item) }
    let!(:invoice_item_3) { create(:invoice_item) }

    it 'id' do
      id = invoice_item_2.id

      get '/api/v1/invoice_items/find', params: {id: id}
      invoice_item = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_item['id']).to eq invoice_item_2.id
      expect(invoice_item['invoice_id']).to eq invoice_item_2.invoice_id
    end

    it 'invoice_id' do
      invoice_id = invoice_item_3.invoice_id

      get '/api/v1/invoice_items/find', params: {invoice_id: invoice_id}
      invoice_item = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_item['id']).to eq invoice_item_3.id
      expect(invoice_item['invoice_id']).to eq invoice_item_3.invoice_id
    end

    it 'item_id' do
      item_id = invoice_item_2.item_id

      get '/api/v1/invoice_items/find', params: {item_id: item_id}
      invoice_item = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_item['id']).to eq invoice_item_2.id
      expect(invoice_item['item_id']).to eq invoice_item_2.item_id
    end

    it 'unit_price' do
      unit_price = invoice_item_2.unit_price

      get '/api/v1/invoice_items/find', params: {unit_price: unit_price}
      invoice_item = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_item['id']).to eq invoice_item_2.id
      expect(invoice_item['unit_price']).to eq invoice_item_2.unit_price
    end

    it 'quantity' do
      quantity = invoice_item_2.quantity

      get '/api/v1/invoice_items/find', params: {quantity: quantity}
      invoice_item = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_item['id']).to eq invoice_item_2.id
      expect(invoice_item['quantity']).to eq invoice_item_2.quantity
    end

    it 'created_at' do
      invoice_item_3.update(created_at: date)

      get '/api/v1/invoice_items/find', params: {created_at: date}
      invoice_item = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_item['id']).to eq invoice_item_3.id
      expect(invoice_item['invoice_id']).to eq invoice_item_3.invoice_id
    end

    it 'updated_at' do
      invoice_item_2.update(updated_at: date)

      get '/api/v1/invoice_items/find', params: {updated_at: date}
      invoice_item = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_item['id']).to eq invoice_item_2.id
      expect(invoice_item['invoice_id']).to eq invoice_item_2.invoice_id
    end

    it 'multiple attributes' do
      invoice_item_3.update(created_at: date)
      invoice_item_3.update(updated_at: date)

      get '/api/v1/invoice_items/find', params: {created_at: date, updated_at: date}
      invoice_item = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_item['id']).to eq invoice_item_3.id
      expect(invoice_item['invoice_id']).to eq invoice_item_3.invoice_id
    end
  end

  context 'find_all' do
    let!(:invoice) { create(:invoice) }
    let!(:invoice_5) { create(:invoice, id: 5) }
    let!(:item) { create(:item) }
    let!(:item_4) { create(:item, id: 4) }

    let!(:invoice_item_1) { create(:invoice_item) }
    let!(:invoice_item_2) { create(:invoice_item, quantity: 3, unit_price_in_cents: 12_34, invoice_id: 5) }
    let!(:invoice_item_3) { create(:invoice_item, quantity: 3, item_id: 4) }
    let!(:invoice_item_4) { create(:invoice_item, quantity: 2, invoice_id: 5, item_id: 4, unit_price_in_cents: 12_34, created_at: date, updated_at: date) }
    let!(:invoice_item_5) { create(:invoice_item, quantity: 11, invoice_id: 5, item_id: 4, updated_at: date) }
    let!(:invoice_item_6) { create(:invoice_item, quantity: 11, invoice_id: 5, unit_price_in_cents: 12_34, created_at: date, updated_at: date) }

    it 'invoice_id' do
      get '/api/v1/invoice_items/find_all', params: {invoice_id: 5}
      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items).to be_a Array
      expect(invoice_items.count).to eq 4
      invoice_items.each do |invoice_item|
        expect(invoice_item['invoice_id']).to eq 5
      end
    end

    it 'item_id' do
      get '/api/v1/invoice_items/find_all', params: {item_id: 4}
      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items).to be_a Array
      expect(invoice_items.count).to eq 3
      invoice_items.each do |invoice_item|
        expect(invoice_item['item_id']).to eq 4
      end
    end

    it 'unit_price' do
      unit_price = "12.34"

      get '/api/v1/invoice_items/find_all', params: {unit_price: unit_price}
      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items).to be_a Array
      expect(invoice_items.count).to eq 3
      invoice_items.each do |invoice_item|
        expect(invoice_item['unit_price']).to eq "12.34"
      end
    end

    it 'quantity' do
      get '/api/v1/invoice_items/find_all', params: {quantity: 3}
      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items).to be_a Array
      expect(invoice_items.count).to eq 2
      invoice_items.each do |invoice_item|
        expect(invoice_item['quantity']).to eq 3
      end
    end

    it 'created_at' do
      get '/api/v1/invoice_items/find_all', params: {created_at: date}
      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items).to be_a Array
      expect(invoice_items.count).to eq 2
    end

    it 'updated_at' do
      get '/api/v1/invoice_items/find_all', params: {updated_at: date}
      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items).to be_a Array
      expect(invoice_items.count).to eq 3
    end

    it 'mutiple attributes' do
      get '/api/v1/invoice_items/find_all', params: {quantity: 11, invoice_id: 5}
      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items).to be_a Array
      expect(invoice_items.count).to eq 2
      invoice_items.each do |invoice_item|
        expect(invoice_item['quantity']).to eq 11
        expect(invoice_item['invoice_id']).to eq 5
      end
    end
  end
end
