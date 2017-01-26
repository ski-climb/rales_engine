require 'rails_helper'

describe 'Customer API favorite merchant' do
  context 'customer with transactions' do
    it 'returns favorite merchant' do
      customer = create(:customer)
      favorite_merchant = create(:merchant)
      other_merchant = create(:merchant)

      favorite_merchant_invoices = create_list(:invoice, 5, merchant: favorite_merchant, customer: customer)
      other_merchant_invoices = create_list(:invoice, 6, merchant: other_merchant, customer: customer)

      favorite_merchant_invoices.each do |invoice|
        create_list(:transaction, 2, invoice: invoice, result: 'success')
      end

      other_merchant_invoices.each do |invoice|
        create(:transaction, invoice: invoice, result: 'failed')
      end

      other_merchant_invoices.each do |invoice|
        create(:transaction, invoice: invoice, result: 'success')
      end

      get "/api/v1/customers/#{customer.id}/favorite_merchant"
      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant).to be_a Hash
      expect(merchant['name']).to eq favorite_merchant.name
      expect(merchant['id']).to eq favorite_merchant.id
    end
  end
end
