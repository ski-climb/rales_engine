class API::V1::Items::BestDayController < ApplicationController
  def show
    item = Item.find(params[:item_id])
    render json: item.best_day
  end
end