class ItemSerializer < ActiveModel::Serializer
  attributes :id,
             :merchant_id,
             :name,
             :description,
             :unit_price

  def unit_price
    (object.unit_price_in_cents / 100.to_f).to_s
  end
end
