require 'rails_helper'

describe 'Items API' do
  it 'returns day with most sales' do
    best_day = '2012-03-22T03:55:09.000Z'
    other_day = '2012-03-20T23:57:05.000Z'

    item = create(:item)

    invoice_on_best_day = create(:invoice, created_at: best_day)
    invoice_on_other_day = create(:invoice, created_at: other_day)

    10.times do
      create(:invoice_item, item: item, invoice: invoice_on_best_day, quantity: 2)
    end

    12.times do
      create(:invoice_item, item: item, invoice: invoice_on_other_day, quantity: 1)
    end

    get "/api/v1/items/#{item.id}/best_day"
    response_day = JSON.parse(response.body)

    expect(response_day['best_day']).to eq best_day
  end

  context 'when there is a tie' do
    it 'returns most recent day' do
    first_day = '2012-03-20T23:57:05.000Z'
    second_day = '2012-03-22T03:55:09.000Z'

    item = create(:item)

    invoice_on_second_day = create(:invoice, created_at: second_day)
    invoice_on_first_day = create(:invoice, created_at: first_day)

    create(:invoice_item, item: item, invoice: invoice_on_second_day, quantity: 5)
    create(:invoice_item, item: item, invoice: invoice_on_first_day, quantity: 5)

    get "/api/v1/items/#{item.id}/best_day"
    response_day = JSON.parse(response.body)

    expect(response_day['best_day']).to eq second_day
    end
  end
end