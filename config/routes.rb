Rails.application.routes.draw do
  
  devise_for :users
  
  resources :courses do
    resources :reviews, except: [:show, :index]
  end
  
  root to: "courses#index"
  
end
