class API::V1::Merchants::RevenueController < ApplicationController
  def show
    revenue = Merchant.find(params[:merchant_id]).revenue(params[:date])
    render json: revenue, serializer: MerchantRevenueSerializer
  end
end