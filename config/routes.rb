Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'tasks#index'
  resources :tasks, only: [:index, :create, :new, :edit, :show, :update, :destroy]
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create]
end
