class API::V1::Transactions::FindController < ApplicationController

  def show
    render json: Transaction.find_by(search_params)
  end

  def index
    render json: Transaction.where(search_params)
  end

  private
  
  def search_params
    params.permit(:id, :invoice_id, :result, :credit_card_number, :updated_at, :created_at)
  end

end
