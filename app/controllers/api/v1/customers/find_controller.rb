class API::V1::Customers::FindController < ApplicationController

  def show
    render json: Customer.find_by(search_params)
  end

  def index
    render json: Customer.where(search_params)
  end

  private
  
  def search_params
    params.permit(:id, :first_name, :last_name, :updated_at, :created_at)
  end

end
