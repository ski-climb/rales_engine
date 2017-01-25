class API::V1::Items::FindController < ApplicationController

  def show
    render json: Item.find_by(search_params)
  end

  def index
    render json: Item.where(search_params)
  end

  private

    def incoming_params
      params.permit(
        :id,
        :name,
        :description,
        :unit_price,
        :merchant_id,
        :created_at,
        :updated_at
      )
    end

    def set_unit_price
      (params[:unit_price].to_f * 100).round
    end

    def search_params
      parameters = incoming_params
      parameters[:unit_price_in_cents] = set_unit_price if params[:unit_price]
      parameters.except("unit_price")
    end
end
