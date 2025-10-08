Rails.application.routes.draw do
  defaults format: :json do
    resources :menus, only: [:index, :show, :create, :update, :destroy]
    resources :menu_items, only: [:index, :show, :create, :update, :destroy]
  end

  # Health check endpoint (útil para monitoramento)
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
