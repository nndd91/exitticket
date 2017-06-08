Rails.application.routes.draw do

  resources :form_templates do
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'forms#index'

  resources :forms do
    member do
      get 'attempt'
      post 'attempting'
      get 'status'
    end
  end
end
