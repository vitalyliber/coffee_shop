Rails.application.routes.draw do
  devise_for :users

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  authenticate :user do
    root 'homes#index'
    resources :orders
    resources :calendars
    resources :calendar_points
    resources :order_points
  end

  mount GrapeSwaggerRails::Engine => '/api/docs'
  mount API::Root => '/'
end
