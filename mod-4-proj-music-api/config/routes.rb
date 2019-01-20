Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users
        get '/current_user', to: 'auth#create'
        get '/signup', to: 'auth#create'
        post '/login', to: 'auth#create'
      resources :playlists
      resources :tracks do
        collection do
          get :top_100
          get :random
          get :search
        end
      end
    end
  end
end
