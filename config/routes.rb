Rails.application.routes.draw do
  # admin
  root 'home#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # api
  namespace :api do
    namespace :v1 do
      resources :animes, param: :public_uid do
        resource :watch_logs
      end
      resources :companies, param: :public_uid
      resources :users, param: :uid
      resource :relationships, only: %i[create destroy]
    end
  end
end
