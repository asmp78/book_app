# frozen_string_literal: true

Rails.application.routes.draw do
  # get 'users/show'
  scope "(:locale)" do
    resources :books
    devise_for :users, controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations"
    }
    resources :users, only: [:show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "books#index"
end
