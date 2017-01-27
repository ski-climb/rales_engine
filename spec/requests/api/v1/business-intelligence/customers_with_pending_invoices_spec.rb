require 'rails_helper'

describe 'Merchants API customers with pending invoices' do
  context 'transactions all failed for an invoice' do
    it 'returns customers' do
      merchant = create(:merchant)
      customer_1, customer_2, customer_3, customer_4 = create_list(:customer, 4)

      invoice_1 = create(:invoice, customer: customer_1, merchant: merchant)
      invoice_2 = create(:invoice, customer: customer_2, merchant: merchant)
      invoice_3 = create(:invoice, customer: customer_3, merchant: merchant)
      invoice_4 = create(:invoice, customer: customer_4, merchant: merchant)

      create(:transaction, invoice: invoice_1, result: 'failed')
      create(:transaction, invoice: invoice_1, result: 'failed')

      create(:transaction, invoice: invoice_2, result: 'failed')
      
      create(:transaction, invoice: invoice_3, result: 'success')
      create(:transaction, invoice: invoice_3, result: 'failed')

      create(:transaction, invoice: invoice_4, result: 'success')

      get "/api/v1/merchant/#{merchant.id}/customers_with_pending_invoices"
      customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(customers).to be_a Array
      expect(customers.length).to eq 2
      expect(customers.first['id']).to eq customer_1.id
      expect(customers.last['id']).to eq customer_2.id
    end
  end
end
