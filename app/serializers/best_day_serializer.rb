class BestDaySerializer < ActiveModel::Serializer
  attributes :best_day

  def best_day
    time = DateTime.parse(object.to_s)
    time.strftime("%Y-%m-%dT%H:%M:%S").to_s + '.000Z'    
  end
end
