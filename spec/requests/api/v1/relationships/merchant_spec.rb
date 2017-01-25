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
  end
