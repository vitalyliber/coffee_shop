Rails.application.routes.draw do
  devise_for :users

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  authenticate :user do
    root 'points#index'

    resources :calendars
    resources :calendar_points
    resources :order_points
    resources :points do
      resources :orders
      resources :products
    end
  end

  mount GrapeSwaggerRails::Engine => '/api/docs'
  mount API::Root => '/'
end
