# add-captcha
> 添加验证码。

## resources
- http://akgitcom.github.io/2015/01/12/Rails-4-1-6-%E4%BD%BF%E7%94%A8Devise-%E5%92%8CSimple-Captcha-%E9%AA%8C%E8%AF%81%E7%A0%81/
- https://www.itdaan.com/blog/2016/08/09/bdea499a867bb990e5947c586dd494c6.html
- https://blog.csdn.net/qwbtc/article/details/52165962
- http://kiskolabs.github.io/humanizer/
- https://github.com/heartcombo/devise/wiki/How-To:-Use-Recaptcha-with-Devise
- https://github.com/heartcombo/devise/issues/2106


## steps
1. add gem
    ```ruby
    gem "simple_captcha2", require: "simple_captcha"
    ```
2. 添加到 form 中去。
    1. 特别注意，最终的参数是添加到 `params[:captcha]` 中去
    2. 而不是添加到 `params[:user]` 中去
```html
<!--/Users/feizheng/github/rails-module-devise/app/views/devise/sessions/new.html.erb-->

  <div class="field">
    <%= show_simple_captcha(:label => "human authentication") %>
  </div>
```

3.  复写 controller 

```ruby
class SessionsController < Devise::SessionsController
  include SimpleCaptcha::ControllerHelpers
  # prepend_before_action :require_no_authentication, :only => [:create]

  def create
    puts params
    if simple_captcha_valid?
      super
    else
      flash[:alert] = "Captcha code is wrong, try again."
      self.resource = resource_class.new(sign_in_params)
      respond_with_navigational(resource) { render :new }
    end
  end
end
```

4. routes 也对应改到这个上面来：
```ruby
# 原来的
devise_for :users

# 新的：
devise_for :users, :controllers => { :sessions => "sessions" }
```

## i18n
- https://github.com/pludoni/simple-captcha/tree/v0.2.2
```yaml
en:
  simple_captcha:
    placeholder: "Enter the image value"
    label: "Enter the code in the box:"
    message:
      default: "Secret Code did not match with the Image"
      user: "The secret Image and code were different"
```


## settings
- https://github.com/pludoni/simple-captcha/tree/v0.2.2

```ruby
SimpleCaptcha.setup do |sc|
  # default: 100x28
  sc.image_size = '120x40'

  # default: 5
  sc.length = 6

  # default: simply_blue
  # possible values:
  # 'embosed_silver',
  # 'simply_red',
  # 'simply_green',
  # 'simply_blue',
  # 'distorted_black',
  # 'all_black',
  # 'charcoal_grey',
  # 'almost_invisible'
  # 'random'
  sc.image_style = 'simply_green'

  # default: low
  # possible values: 'low', 'medium', 'high', 'random'
  sc.distortion = 'medium'
end
```
