class API::V1::Merchants::RevenueBySecondController < ApplicationController
  def show
    total_revenue = Merchant.revenue_by_day(params[:date])
    render json: total_revenue, serializer: MerchantTotalRevenueSerializer
  end
end
