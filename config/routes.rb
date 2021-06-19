# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post 'sign_up', action: :create, controller: 'users'
      post 'sign_in', action: :login, controller: 'authentication'
      resources :profile, only: %i[], controller: 'users' do
        collection do
          delete 'destroy'
          put 'update'
          get 'show'
        end
      end
      resources :articles
    end
  end
  get '/*a', to: 'application#not_found'
end
