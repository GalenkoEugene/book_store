# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'home#index'
  resources :book, only: [:show, :index]
  resource :cart, only: [:show, :update]
  resources :order_items, only: [:create, :update, :destroy]
  match '/catalog', to: 'book#index', via: 'get'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [:update]
  resources :settings
  resources :reviews, only: :create
end
