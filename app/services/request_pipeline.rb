# frozen_string_literal: true
class RequestPipeline
  attr_reader :params, :api_params

  def initialize(params, api_params)
    @params = params
    @api_params = api_params
  end

  def execute
    values = route_map

    return {} if values.empty?

    Services::Requester.make_request( values[:verb],
                                      values[:url],
                                      { 'X-API-TOKEN': values[:token] },
                                      api_params )
  end

  private

  def route_map
    verb = params[:method].to_s.downcase


    url_pattern = params[:url_pattern].gsub('/api/', '').gsub('(.:format)', '')
    version = url_pattern.split('/').shift

    route = Route.where({ verb: verb,
                          version: version,
                          url_pattern: url_pattern }).last

    return {} unless route

    service = route.service
    {
      verb: verb,
      url: "#{service.url}#{params[:path]}",
      token: service.token
    }
  end
end
