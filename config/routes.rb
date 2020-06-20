# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  scope "(:locale)" do
    devise_for :users, skip: :omniauth_callbacks, controllers: {
      registrations: "users/registrations"
    }
    resources :books
    resources :users, only: [:index, :show]
    resources :users do
      resources :followings, only: [:index], controller: "users/followings"
      resources :followers, only: [:index], controller: "users/followers"
    end
    resources :relationships, only: [:create, :destroy]
  end
  root to: "books#index"
end
