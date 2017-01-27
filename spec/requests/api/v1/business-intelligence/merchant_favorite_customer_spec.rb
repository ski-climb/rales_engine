require 'rails_helper'

describe 'Merchant API favorite customer' do
  context 'merchant with transactions' do
    let!(:merchant) { create(:merchant) }
    let!(:favorite_customer) { create(:customer) }
    let!(:other_customer) { create(:customer) }

    it 'returns favorite customer' do
      10.times { create(:invoice, merchant: merchant, customer: other_customer) }
      6.times  { create(:invoice, merchant: merchant, customer: favorite_customer) }

      other_customer.invoices.each do |invoice|
        create(:transaction, result: "failed", invoice: invoice)
      end

      favorite_customer.invoices.each do |invoice|
        create_list(:transaction, 2, result: "success", invoice: invoice)
      end

      get "/api/v1/merchants/#{merchant.id}/favorite_customer"
      response_customer = JSON.parse(response.body)

      expect(response).to be_successful
      expect(response_customer).to be_a Hash
      expect(response_customer['id']).to eq favorite_customer.id
      expect(response_customer['first_name']).to eq favorite_customer.first_name
    end
  end
end
