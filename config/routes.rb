Rails.application.routes.draw do
  get 'labels/new'
  get 'labels/create'
  get 'labels/show'
  get 'labels/edit'
  get 'labels/update'
  get 'labels/destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'tasks#index'
  resources :tasks, only: [:index, :create, :new, :edit, :show, :update, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :edit, :update]
  namespace :admin do
    resources :users, only: [:index, :create, :new, :edit, :show, :update, :destroy]
  end
  resources :labels, only: [:index, :create, :new, :edit, :show, :update, :destroy]
  get '*path', to: 'application#render_404'
end
