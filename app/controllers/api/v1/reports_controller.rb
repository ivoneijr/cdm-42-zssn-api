class API::V1::ReportsController < ApplicationController

  # GET /api/v1/reports
  def index
    render json: Report.build
  end

end
