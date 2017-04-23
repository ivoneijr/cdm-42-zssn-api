class API::V1::ItemsController < ApplicationController
  include ItemsHelper

  before_action :load_dealers_and_validations, only: [:trade]

  # GET /api/v1/items
  def index
    render json: Item.all
  end

  # POST /api/v1/items/trade
  def trade
    unless @trade_errors.empty?
      render json: { errors: @trade_errors }, status: :unprocessable_entity
    else
      render json: { ok: "¯\_(ツ)_/¯"}, status: :ok
    end
  end

  private
    def load_dealers_and_validations
      @trade_errors = []
      @dealers = get_dealers(params)

      if @dealers.count == 2
        make_swap if can_trade? && equal_points? && can_swap?
      end
    end

    def make_swap
      @dealers.each { |dealer| dealer.update_inventory(@dealers) }
    end
end