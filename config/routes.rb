Rails.application.routes.draw do
  root to: 'message#index'
  resources :message, only: [:index, :show]
  require "sidekiq/web"
  mount Sidekiq::Web => '/sidekiq'

  post "update", to: "message#grab"
end
