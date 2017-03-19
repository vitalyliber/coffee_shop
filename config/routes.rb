Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users" }

  devise_scope :user do
    delete 'sign_out', :to => 'users#destroy', :as => :destroy_user_session
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'homes#index'

  resources :barmans, only: :index do
    member do
      get :activate
    end
  end

  authenticate :user do
    resources :points do
      get :till
      resources :orders do
        collection do
          get :day_sales, as: :sales
        end
      end
      resources :products
      resources :barmans do
        member do
          get :self_destroy
        end
      end
      member do
        get :set
        get :start_sales, as: :sale
        delete :end_sales, as: :close
      end
    end
  end

  mount GrapeSwaggerRails::Engine => '/api/docs'
  mount API::Root => '/'
end
