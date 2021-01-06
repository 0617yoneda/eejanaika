Rails.application.routes.draw do
  get 'post_comments/destroy'
  get 'posts/index'
  get 'posts/edit'
  get 'posts/update'
  get 'customers/index'
  get 'customers/edit'
  get 'customers/update'
  get 'customers/show'
  get 'customers/edit'
  get 'customers/update'
  get 'customers/out'
  get 'customers/hide'
  get 'searches/search'
  get 'notifications/index'
  get 'notifications/destroy'
  get 'categories/index'
  get 'favorites/create'
  get 'favorites/destroy'
  get 'posts_comments/create'
  get 'posts_comments/destroy'
  get 'posts/new'
  get 'posts/create'
  get 'posts/index'
  get 'posts/show'
  get 'posts/edit'
  get 'posts/update'
  get 'homes/top'
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }

  namespace :admins do
    resources :customers, only: [:index, :edit, :update]
    resources :posts, only: [:index, :edit, :update]
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
  resources :posts, only: [:index, :edit, :update, :new, :show, :create] do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  get "categories/:id/posts" => "categories#index", as: "category_posts"
  resources :notifications, only: [:index, :destroy]
  get "searches" => "searches#search", as: "searches"




end
