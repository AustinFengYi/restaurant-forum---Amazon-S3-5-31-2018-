Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "restaurants#index"
  resources :restaurants,only: [:index,:show] do
    collection do
      get :feeds
    end

    member do
      get :dashboard
    end

    #在這裡因為 favorite / unfavorite action 不需要樣板，所以我們習慣使用 POST，而不是 GET。
    member do
      post :favorite
      post :unfavorite
    end

    member do
      post :like
      post :unlike
    end

    collection do
      get :rankings
    end

  end


  namespace :admin do
    root "restaurants#index"
    resources :restaurants
    resources :categories
  end

  resources :categories ,only: :show

  resources :restaurants , only: [:index ,:show] do
    resources :comments, only: [:create, :destroy] 
  end

  resources :users, only: [:index,:show,:edit,:update] do
    member do
      get :friend_list
    end
  end

  resources :followships, only: [:create, :destroy]

  resources :friendships, only: [:create, :destroy] do
    member do
      post :confirm
      delete :refuse
    end
  end

end
