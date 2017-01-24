require 'rails_helper'

describe 'Merchants API' do
  it 'returns a list of merchants' do
    merchant1, merchant2, merchant3 = create_list(:merchant, 3)
    name = merchant1.name

    get '/api/v1/merchants'
    merchants = JSON.parse(response.body)
    merchant = merchants.first

    expect(response).to be_success
    expect(merchants.count).to eq 3
    expect(merchant['name']).to eq name
  end

  it 'returns a single merchant' do
    create(:merchant, id: 5)

    get '/api/v1/merchants/5'
    merchant = JSON.parse(response.body)

    expect(response).to be_success

    expect(merchant).to be_a Hash
    expect(merchant.keys.count).to eq 2
    expect(merchant).to have_key 'id'
    expect(merchant).to have_key 'name'
    expect(merchant['name']).to be_a String
    expect(merchant['id']).to be_a Integer
  end
end
