require 'rails_helper'

describe 'Items API' do
  it 'returns day with most sales' do
    best_day = '2012-03-22T03:55:09.000Z'
    other_day = '2012-03-20T23:57:05.000Z'

    item = create(:item)

    invoice_on_best_day = create(:invoice, created_at: best_day)
    invoice_on_other_day = create(:invoice, created_at: other_day)

    10.times do |n|
      create(:invoice_item, item: item, invoice: invoice_on_best_day, quantity: 2)
    end

    4.times do |n|
      create(:invoice_item, item: item, invoice: invoice_on_other_day, quantity: 4)
    end

    get "/api/v1/items/#{item.id}/best_day"
    response_day = JSON.parse(response.body)

    expect(response_day).to eq best_day
  end

  context 'when there is a tie' do
    it 'returns most recent day' do

    end
  end
end