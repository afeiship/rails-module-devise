# add column 
- https://ihower.tw/rails/auth.html
- https://www.jianshu.com/p/93cb9d8c5e36

## steps
1. add migrate
```shell
rails g migration add_nickname_to_users
```
2. add fields
```rb
add_column :users, :nickname, :string
```

3. application_controller.rb
```rb
class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    # ...

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
      devise_parameter_sanitizer.permit(:account_update, keys: [:nickname])
    end
  end
```
