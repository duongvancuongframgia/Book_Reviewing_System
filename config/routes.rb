Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  namespace :admin do
    root "static_pages#home"
    resources :categories, except: :show
    resources :books
    resources :users
    resources :reviews, only: [:index, :show, :destroy, :edit]
  end
  resources :users, except: [:destroy] do
    resources :following, only: :index
    resources :followers, only: :index
    resources :reviews, only: :index
  end
  resources :books, only: [:index, :show] do
    resources :reviews do
      resources :comments
    end
    resources :rates, except: :destroy
  end
  resources :relationships, only: [:create, :destroy]
  resources :favourites, only: [:create, :destroy]
  resources :readings, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :rates, only: [:create, :update]
  resources :activities, only: [:create, :destroy]
  resources :account_activations, only: [:edit]
end
