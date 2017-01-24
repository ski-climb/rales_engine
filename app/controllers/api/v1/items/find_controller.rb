class API::V1::Items::FindController < ApplicationController

  def show
    render json: Item.find_by(search_params)
  end

  private

    def search_params
      params.permit(
        :id,
        :name,
        :description,
        :merchant_id,
        :created_at,
        :updated_at
      )
    end
end
