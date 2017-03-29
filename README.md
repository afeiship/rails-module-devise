# rails-module-devise
> Rails module for devise.

## Step by step:
+ some code:
```bash
# add this to Gemfile: `gem 'devise'`
rails generate devise:install
rails generate devise User
rails generate controller Home index
rake db:migrate
```

+ config:
# config/environments/development.rb:
```ruby
config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
```

+ routes:
```ruby
Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
end
```


## resources:
+ https://github.com/plataformatec/devise