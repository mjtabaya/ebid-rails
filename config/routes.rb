Rails.application.routes.draw do
  root "home#index"
  get "auctions", to: "auctions#index"
  post "bid", to: "bids#create"

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  resources :users do
    resources :auctions
    resources :bids
  end

  resources :auctions do
    resources :bid_entries
  end

  resources :bid_entries do
    resources :products
    resources :bids
  end
end
