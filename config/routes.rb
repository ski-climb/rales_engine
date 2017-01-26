Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get "/find", to: "find#show"
        get "/find_all", to: "find#index"
        get "/random", to: "random#show"
        get "/revenue", to: "revenue_by_second#show"
      end
      resources :merchants, only: [:index, :show] do
        scope module: :merchants do
          resources :invoices, only: [:index]
          resources :items, only: [:index]
          get "/revenue", to: "revenue#show"
        end
      end

      namespace :items do
        get "/find",     to: "find#show"
        get "/find_all", to: "find#index"
        get "/random",   to: "random#show"
        get "/most_revenue", to: "most_revenue#index"
      end
      resources :items, only: [:index, :show] do
        scope module: :items do
          get "/best_day", to: "best_day#show"
        end
      end

      namespace :customers do
        get "/find", to: "find#show"
        get "/find_all", to: "find#index"
        get "/random", to: "random#show"
      end
      resources :customers, only: [:index, :show] do
        scope module: :customers do
          resources :invoices, only: [:index]
          resources :transactions, only: [:index]
          get "/favorite_merchant", to: "favorite_merchant#show"
        end
      end

      namespace :transactions do
        get "/find", to: "find#show"
        get "/find_all", to: "find#index"
        get "/random", to: "random#show"
      end

      resources :transactions, only: [:show, :index] do
        scope module: :transactions do
          get "/invoice", to: "invoice#show"
        end
      end

      namespace :invoice_items do
        get "/find",     to: "find#show"
        get "/find_all", to: "find#index"
        get "/random",   to: "random#show"
      end
      resources :invoice_items, only: [:index, :show] do
        scope module: :invoice_items do
          get "/invoice", to: "invoice#show"
          get "/item",    to: "item#show"
        end
      end

      namespace :invoices do
        get "/find",     to: "find#show"
        get "/find_all", to: "find#index"
        get "/random",   to: "random#show"
      end
      resources :invoices, only: [:index, :show]
    end
  end
end
