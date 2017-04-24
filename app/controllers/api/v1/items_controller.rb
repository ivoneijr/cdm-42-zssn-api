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
      render json: { message: 'Successful items trade.'}, status: :ok
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
      ActiveRecord::Base.transaction do
        @dealers.each do |dealer|
          dealer.remove_proposed_items
          dealer.add_or_update_new_items
        end
      end
    end
end