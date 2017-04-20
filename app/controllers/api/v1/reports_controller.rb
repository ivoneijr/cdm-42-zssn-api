class API::V1::ReportsController < ApplicationController
  include ReportsHelper

  # GET /api/v1/reports
  def index
    types = params[:types]
    build_params types

    render json: Report.build(types)
  end
end
