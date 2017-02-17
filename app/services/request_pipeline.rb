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

    # query
    version, url_pattern = map_url_pattern(params[:path].dup)

    # Rails.application.routes.recognize_path('/your/path/here')
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

  def map_url_pattern(path)
    # "/api/v1/projects/1"
    path = path.gsub('/api/', '')
    # "v1/projects/1"
    path  = path.split('?')[0]

    splitted_path = path.split('/')
    version = splitted_path.shift
    # this is like a hacky, need to find other approach to match
    # api_params: {id: '1'}
    # path: "v1/projects/1"
    # mapped_url_pattern: "v1/projects/:id"
    splitted_path = splitted_path.map do |_path|
      if key = api_params.invert[_path]
        api_params.delete(key)
        ":#{key}"
      else
        _path
      end
    end

    [version, splitted_path.join('/')]
  end
end
