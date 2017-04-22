class API::V1::ItemsController < ApplicationController
  before_action :set_dealers, only: [:trade]

  # GET /api/v1/items
  def index
    render json: Item.all
  end

  # POST /api/v1/items/trade
  def trade
    render json: { ok: "¯\_(ツ)_/¯"}
  end

  def set_dealers

  end
end
