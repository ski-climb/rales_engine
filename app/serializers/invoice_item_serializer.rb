class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :id,
             :invoice_id,
             :item_id,
             :quantity,
             :unit_price

  def unit_price
    (object.unit_price_in_cents / 100.to_f).to_s
  end
end
