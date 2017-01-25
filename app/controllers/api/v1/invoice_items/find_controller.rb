class API::V1::InvoiceItems::FindController < ApplicationController

  def index
    render json: InvoiceItem.where(search_params)
  end

  def show
    render json: InvoiceItem.find_by(search_params)
  end

  private

    def incoming_params
      params.permit(
        :id,
        :invoice_id,
        :item_id,
        :quantity,
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
