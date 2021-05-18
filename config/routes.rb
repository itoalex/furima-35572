Rails.application.routes.draw do
  devise_for :users

  root to: "items#index"

  resources :items do
    resources :item_record, only: [:index, :create, :new]
  end

  resources :user

end


