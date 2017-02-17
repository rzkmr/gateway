class RoutesController < ApplicationController
  before_action :find_route, only: [:show, :update, :delete]

  def index
    render json: Route.all, status: 200
  end

  def show
    render json: @route, status:200
  end

  def create
    route_params = params_permit
    #validate service exists
    route = Route.create(route_params)
    DynamicRouter.reload
    render json: route, status: 201
  end

  def update
    route_params = params_permit
    @route.update_attributes(route_params)
    DynamicRouter.reload
    render json: @route, status: 200
  end

  def destroy
    api_error(500) unless @route.destroy!
    DynamicRouter.reload
    head :no_content
  end

  private

  def params_permit
    params.permit(:service_id, :verb, :url_pattern, :version)
  end

  def find_route
    @route = Route.find(params[:id])
    api_error(404, 'route not found') unless @route
  end
end
