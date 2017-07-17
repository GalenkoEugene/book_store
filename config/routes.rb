# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'
  resources 'book'
  match '/catalog', to: 'book#index', via: 'get'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
