class GatewaysController < ApplicationController
  # todo: authentication

  def status
    render json: { message: 'App is up and running' }, status: 200
  end

  def call
    request_values = {
      method: request.method,
      path: request.fullpath,
      remote_addr: request.remote_addr,
      query_string: request.query_string
    }
    # todo: validate, handle post, filter request
    params.permit!
    # filter_out rails params and collect required params
    filtered_api_params = params.except(*['controller', 'action', 'gateway']).to_h
    response = RequestPipeline.new(request_values, filtered_api_params).execute

    api_error(404, 'route not found') if response.empty?

    render json: response, status: 200
  end
end
