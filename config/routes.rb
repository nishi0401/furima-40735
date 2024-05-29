Rails.application.routes.draw do
  devise_for :users
  resources :items do
    resources :purchase_records, only:[:index, :create]
  end
  root to: 'items#index'

end
