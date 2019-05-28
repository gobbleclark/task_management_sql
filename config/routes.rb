Rails.application.routes.draw do
  devise_for :users
  root "boards#index"
  resources :boards do
    resources :lists do
      resources :tasks
    end
  end
  
  # resources :lists do
  #   resources :tasks
  # end

end
