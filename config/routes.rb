Rails.application.routes.draw do
  root 'home#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  namespace :api do
    namespace :v1 do
      resources :animes, param: :public_uid
      resources :companies, param: :public_uid
      resources :users, param: :uid
    end
  end
end
