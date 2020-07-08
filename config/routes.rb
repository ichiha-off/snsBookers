Rails.application.routes.draw do

  root :to => "users#top"

  get "home/about" => "users#about"

  devise_for :users

  resources :books, only: [:index, :create, :show, :edit, :update, :destroy] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get "followers" => "relationships#follower"
    get "followings" => "relationships#following"
  end

  get "/search" => "search#search"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
