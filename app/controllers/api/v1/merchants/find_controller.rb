class API::V1::Merchants::FindController < ApplicationController

  def show
    render json: Merchant.find_by(find_params)
  end

  private

  def find_params
    params.permit(:id)
  end

end
