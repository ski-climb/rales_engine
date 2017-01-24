Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get "/find", to: "find#show"
        get "/find_all", to: "find#index"
        get "/random", to: "random#show"
      end

      namespace :items do
        get "/find", to: "find#show"
      end

      resources :merchants, only: [:index, :show]
      resources :items, only: [:index, :show]
    end
  end
end
