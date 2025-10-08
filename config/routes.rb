Rails.application.routes.draw do
  defaults format: :json do
    resources :restaurants, only: [:index, :show, :create, :update, :destroy] do
      resources :menus, only: [:index, :show, :create, :update, :destroy]
    end
    
    resources :menu_items, only: [:index, :show, :create, :update, :destroy]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end