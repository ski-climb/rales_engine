class MerchantRevenueSerializer < ActiveModel::Serializer
  attributes :revenue
  
  def revenue
    object.to_f / 100
  end
end
