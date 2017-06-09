Rails.application.routes.draw do

  resources :formtemplates do
    resources :questions
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'forms#index'

  resources :forms do
    member do
      get 'attempt'
      post 'attempting'
      get 'status'
      get 'results'
    end
  end
end
