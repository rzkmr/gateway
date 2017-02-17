class ApplicationController < ActionController::API
  # before_action :authenticate

  # bottom-up order for exception is needed
  rescue_from Exception, with: :handle_exception
  rescue_from APIError, with: :handle_api_error

  protected

  def api_error(code, msg = '', request = nil)
    raise APIError.new(code, msg, request)
  end

  def handle_api_error(excp)
    render excp.render_json
  end

  def handle_exception(excp)
    puts excp
    render APIError.new(500, '', request, excp).render_json
  end

  def authenticate
    api_error(401, '', request) unless valid_token?
  end

  def valid_token?
    token = request.env['HTTP_X_API_TOKEN']
    ApiKey.valid_token?(token)
  end
end
