Rails.application.routes.draw do
  # admin
  root 'admin/home#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  scope module: :admin do
    post '/login', to: "login#create"
    delete '/logout', to: "login#destroy"
  end

  # api
  namespace :api do
    namespace :v1 do
      resources :animes, param: :public_uid do
        resource :watch_logs, only: %i[create destroy]
      end
      resources :companies, param: :public_uid, only: %i[index show]
      resources :users, param: :uid, only: %i[show create update destroy]
      resource :relationships, only: %i[create destroy]
      resource :timelines, only: %i[show]
    end
  end
end
