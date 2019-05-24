class DynamicRouter
  def self.load
    # Routes table does not exist at initial app setup and causes to stop db migration
    return unless ActiveRecord::Base.connection.data_source_exists? 'routes'

    Rails.application.routes.draw do
      # todo: check for better route generator
      Route.all.each do |route|
        url_pattern = "api/#{route.version}/#{route.url_pattern}"
        case route.verb
        when 'get'
          get url_pattern, to: 'gateways#call'
        when 'post'
          post url_pattern, to: 'gateways#call'
        when 'put'
          put url_pattern, to: 'gateways#call'
        when  'delete'
          delete url_pattern, to: 'gateways#call'
        end
      end
    end
  end

  def self.reload
    Rails.application.routes_reloader.reload!
  end
end
