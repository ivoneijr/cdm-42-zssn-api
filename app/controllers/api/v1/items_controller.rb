class API::V1::ItemsController < ApplicationController
  
  # GET /api/v1/items
  def index
    render json: Item.all
  end

end
