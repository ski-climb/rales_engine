require 'rails_helper'
  
  describe 'Merchant API relationships' do
  
    it 'invoices' do
      merchant = create(:merchant)
      invoices = create_list(:invoice, 5, merchant: merchant)
      invoice = invoices.first
   
      get "/api/v1/merchants/#{merchant.id}/invoices"
      response_invoices = JSON.parse(response.body)
      response_invoice = response_invoices.first
    
      expect(response).to be_success
      expect(response_invoices).to be_a Array
      expect(response_invoices.count).to eq 5
      expect(response_invoice['id']).to eq invoice.id
      expect(response_invoice['merchant_id']).to eq invoice.merchant_id
      expect(response_invoice['customer_id']).to eq invoice.customer_id
    end
    
    it 'items' do
      merchant = create(:merchant)
      items = create_list(:item, 5, merchant: merchant)
      item = items.first
   
      get "/api/v1/merchants/#{merchant.id}/items"
      response_items = JSON.parse(response.body)
      response_item = response_items.first
    
      expect(response).to be_success
      expect(response_items).to be_a Array
      expect(response_items.count).to eq 5
      expect(response_item['id']).to eq item.id
      expect(response_item['name']).to eq item.name
    end
  end
