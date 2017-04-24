class API::V1::ReportsController < ApplicationController
  include ReportsHelper

  # GET /api/v1/reports
  def index
    types = build_params params[:types]

    render json: Report.build(types)
  end
end
