class API::V1::Merchants::RandomController < ApplicationController
  def show
    render json: Merchant.all.sample
  end
end
