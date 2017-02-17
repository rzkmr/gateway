# frozen_string_literal: true
# display services and its routes
desc 'Display services and its routes'
task service_routes: :environment do
  data = []
  Service.all.each_with_index do |service, i|
    service_name = service.name
    service_url = service.url

    service.routes.each_with_index do |route, j|
      data << :separator if i > 0 && j == 0
      data << [ service_name, service_url, route.verb.upcase, route.version, route.url_pattern]
      service_name=''
      service_url=''
    end
  end

  table = Terminal::Table.new
  table.headings = ['Source', 'Url', 'Verb', 'Version', 'URL Pattern']
  table.rows = data
  table.style = {:padding_left => 1, :border_x => "-", :border_i => "x", :all_separators => false}

  puts table
end
