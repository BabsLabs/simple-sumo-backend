require 'sidekiq/web'

Rails.application.routes.draw do
  resources :users, only: [:create, :show]

  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/logged_in', to: 'sessions#is_logged_in?'

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      username == ENV["admin_username"] && password == ENV["admin_password"]
  end
  mount Sidekiq::Web => '/sidekiq'

end
