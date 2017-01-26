class BestDaySerializer < ActiveModel::Serializer
  attributes :best_day

  def best_day
    object.to_s
  end
end
