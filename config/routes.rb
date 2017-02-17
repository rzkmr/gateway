Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'status', to: 'gateways#status'
  resources 'services'
  resources 'routes'

  DynamicRouter.load
end
