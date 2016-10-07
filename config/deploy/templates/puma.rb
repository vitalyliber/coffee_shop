#!/usr/bin/env puma

directory '/home/publisher/coffee_shop/current'
rackup "/home/publisher/coffee_shop/current/config.ru"
environment 'production'

pidfile "/home/publisher/coffee_shop/shared/tmp/pids/puma.pid"
state_path "/home/publisher/coffee_shop/shared/tmp/pids/puma.state"
stdout_redirect '/home/publisher/coffee_shop/shared/log/puma_access.log', '/home/publisher/coffee_shop/shared/log/puma_error.log', true


threads 0,32

bind 'unix:///home/publisher/coffee_shop/shared/tmp/sockets/puma.sock'

workers 0

prune_bundler


on_restart do
  puts 'Refreshing Gemfile'
  ENV["BUNDLE_GEMFILE"] = "/home/publisher/coffee_shop/current/Gemfile"
end
