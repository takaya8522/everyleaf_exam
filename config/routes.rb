Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'tasks#index'
  resources :tasks, only: [:index, :create, :new, :edit, :show, :update, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  namespace :admin do
    resources :users, only: [:index, :create, :new, :edit, :show, :update, :destroy]
  end
end
