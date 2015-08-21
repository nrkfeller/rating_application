Rails.application.routes.draw do
  
  devise_for :users
  
  resources :courses do
    collection do
      get 'search'
    end
    resources :reviews, except: [:show, :index]
  end
  
  root to: "courses#index"
  
end
