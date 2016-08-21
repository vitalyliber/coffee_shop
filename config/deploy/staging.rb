role :app, %w{publisher@coffee-shop-staging.toel.ru}
role :web, %w{publisher@coffee-shop-staging.toel.ru}
role :db,  %w{publisher@coffee-shop-staging.toel.ru}

server 'coffee-shop-staging.toel.ru', user: 'publisher', roles: %w{web app}, primary: true
set :rails_env, 'staging'
set :deploy_to, "/home/staging/coffee_shop"
set :branch, ENV['BRANCH'] || 'master'