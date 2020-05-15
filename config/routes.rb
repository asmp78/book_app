# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  scope "(:locale)" do
    devise_for :users, skip: :omniauth_callbacks, controllers: {
      registrations: "users/registrations"
    }
    resources :books
    resources :users, only: [:show]
  end
  root to: "books#index"
end
