class ServicesController < ApplicationController
  before_action :find_service, only: [:show, :update, :delete]

  def index
    render json: Service.all, status: 200
  end

  def show
    render json: @service, status:200
  end

  def create
    service_params = params_permit
    service = Service.create(service_params)
    render json: service, status: 201
  end

  def update
    service_params = params_permit
    @service.update_attributes(service_params)
    render json: @service, status: 200
  end

  def destroy
    api_error(500) unless @service.destroy!
    head :no_content
  end


  private

  def params_permit
    params.permit(:name, :url, :token)
  end

  def find_service
    @service = Service.find(params[:id])
    api_error(404, 'service not found') unless @service
  end
end
