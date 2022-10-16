Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :animes, param: :public_uid
    end
  end
end
