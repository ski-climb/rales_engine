require 'rails_helper'

describe 'Merchants API' do
  context 'find by' do
    it 'id' do
      merchant1, merchant2, merchant3 = create_list(:merchant, 3)
      id = merchant1.id

      get '/api/v1/merchants/find', params: {id: id}
      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant['name']).to eq merchant1.name
    end
  end
end
