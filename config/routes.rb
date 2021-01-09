Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/customers'
  }
  


  namespace :admins do
    resources :customers, only: [:index, :edit, :update]
    resources :posts, only: [:index, :show, :destroy]
    resources :post_comments, only: [:destroy]
  end

  devise_for :customers, controllers: {
    sessions:      'customers/sessions',
    passwords:     'customers/passwords',
    registrations: 'customers/registrations'
  }

  root "homes#top"
  resources :customers, only: [:show, :edit, :update]
  get "customers/out" => "customers#out"
  patch "customers/hide" => "customers#hide"
  resources :posts do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  get "categories/:id/posts" => "categories#index", as: "category_posts"
  resources :notifications, only: [:index, :destroy]
  get "searches" => "searches#search", as: "searches"

  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'customers/sessions#new_guest'
  end
end
