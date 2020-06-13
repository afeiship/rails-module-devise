# rails-module-devise
> Rails module for devise.

## steps
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

+ mail settings:
```ruby
# environments/development.rb
config.action_mailer.delivery_method =:smtp
config.action_mailer.smtp_settings = {
    :address=> "smtp.163.com",
    :port=> 25,
    :domain=> "163.com",
    :authentication=> :login,
    :user_name=> "admin@163.com",#你的邮箱
    :password=> 'admin'      #你的密码
}

# project/config/initializers/devise.rb
config.mailer_sender = 'admin@163.com'
```

## resources
- https://github.com/plataformatec/devise
- https://github.com/imhta/rails_6_devise_example
- https://github.com/pludoni/simple-captcha
- https://segmentfault.com/a/1190000014610228
- http://www.imagemagick.org/script/download.php#macosx
- https://stackoverflow.com/questions/7195866/how-to-integrate-a-simple-captcha-with-devise-at-registration-in-rails-3