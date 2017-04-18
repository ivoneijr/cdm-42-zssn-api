class API::V1::SurvivorsController < ApplicationController
  before_action :set_survivor, only: [:show, :update, :destroy, :report_infection]

  # GET /survivors/api/v1
  def index
    @survivors = Survivor.all

    render json: @survivors
  end

  # GET /survivors/api/v1/1
  def show
    render json: @survivor
  end

  # POST /survivors/api/v1
  def create
    @survivor = Survivor.new(survivor_params)

    if @survivor.save
      render json: @survivor, status: :created, location: @survivor
    else
      render json: @survivor.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /survivors/api/v1/1
  def update
    if @survivor.update_location(survivor_params)
      render json: @survivor
    else
      render json: @survivor.errors, status: :unprocessable_entity
    end
  end

  # POST /survivors/api/v1/1/report_infection
  def report_infection
    if @survivor.report_infection(params[:infected_id])
      render json: { message: 'Your report has been registered.' }, status: :created
    else
      render json: { errors: @survivor.errors }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survivor
      @survivor = Survivor.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def survivor_params
      params.require(:survivor).permit(:name, :age, :gender, :last_latitude, :last_longitude)
    end
end
