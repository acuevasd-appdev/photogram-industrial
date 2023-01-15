Rails.application.routes.draw do
  root "photos#index"

  devise_for :users

  resources :comments
  resources :follow_requests
  resources :likes
  resources :photos
 
  get ":username/liked" => "photos#liked", as: :liked_photos
  # get ":username/feed" => ""
  # get ":username/discover" => ""
  # get add post
  get "/:username" => "users#show", as: :user

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
