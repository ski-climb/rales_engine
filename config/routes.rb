Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get "/find", to: "find#show"
        get "/find_all", to: "find#index"
        get "/random", to: "random#show"
        get "/most_items", to: "most_items#index"
        get "/revenue", to: "revenue_by_second#show"
        get "/most_revenue", to: "most_revenue#index"
      end
      resources :merchants, only: [:index, :show] do
        scope module: :merchants do
          resources :invoices, only: [:index]
          resources :items, only: [:index]
          get "/customers_with_pending_invoices", to: "customers_with_pending_invoices#index"
          get "/revenue", to: "revenue#show"
          get "/favorite_customer", to: "favorite_customer#show"
        end
      end

      namespace :items do
        get "/find",     to: "find#show"
        get "/find_all", to: "find#index"
        get "/random",   to: "random#show"
        get "/most_items", to: "most_items#index"
        get "/most_revenue", to: "most_revenue#index"
      end
      resources :items, only: [:index, :show] do
        scope module: :items do
          get "/best_day", to: "best_day#show"
          get "/merchant", to: "merchant#show"
          resources :invoice_items, only: [:index]
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
      resources :invoices, only: [:index, :show] do
        scope module: :invoices do
          resources :transactions, only: [:index]
          resources :invoice_items, only: [:index]
          resources :items, only: [:index]
          get "/customer", to: "customer#show"
          get "/merchant", to: "merchant#show"
        end
      end
    end
  end
end
