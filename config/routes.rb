Rails.application.routes.draw do
  devise_for :users

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  authenticate :user do
    root 'points#index'

    resources :calendars
    resources :calendar_points
    resources :order_points
    resources :points do
      resources :orders do
        collection do
          get :day_sales, as: :sales
        end
      end
      resources :products
      member do
        get :start_sales, as: :sale
      end
    end
  end

  mount GrapeSwaggerRails::Engine => '/api/docs'
  mount API::Root => '/'
end
