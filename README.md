# Coffee Shop

System for sale coffee in your Coffee Shop :coffee:

* Ruby version: 2.3.0

## How to run Coffee Shop: 

You need mac or linux for starting Coffee Shop.

Run this command in your terminal:

_You need to install ruby version manager if it not installed_ :rocket:
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
rails s
```

_Add settings for vkontakte auth to VK app_

[Dev Panel](https://vk.com/apps?act=manage)

```
base_url: http://localhost
redirect_url: http://localhost:3000/users/auth/vkontakte/callback
```

_Add secret settings for VK to secrets.yml_

```yml
development:
  vk_key: XXX
  vk_id: XXX
```

_Link to staging server_ :herb:
