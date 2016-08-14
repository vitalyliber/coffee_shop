# Coffee Shop

System for sale coffee in your Coffee Shop :coffee:

* Ruby version: 2.3.0

## How to run Coffee Shop: 

You need mac or linux for starting Coffee Shop.

Run this command in your terminal:

_You need to install ruby version manager if he not installed_ :rocket:
```shell
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable
```

_Install dependencies for Coffee Shop_ :ice_cream:
```shell
rvm install 2.3.0
rvm use 2.3.0@coffee-shop --create
gem install bundler
bundle install
rake db:migrate
rake db:seed_fu
rails s
```