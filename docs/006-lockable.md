# lockable
- https://www.rubydoc.info/github/plataformatec/devise/Devise/Models/Lockable
- https://github.com/plataformatec/devise/wiki/How-To:-Add-:lockable-to-Users

## steps
1. 添加 `flash` 到 `layout` 中去
```html
  <% flash.each do |type, msg| %>
    <% if type == "notice" %>
      <div class="alert docify-flash is-success">
    <% elsif type == "alert" %>
      <div class="alert docify-flash is-danger">
    <% else %>
      <div class='alert docify-flash is-<%= "#{type}" %>'>
    <% end %>
    <a href="#" class="close" data-dismiss="alert">&#215;</a>
    <ul>
      <li>
        <%= msg %>
      </li>
    </ul>
    </div>
  <% end %>
```

2. 打开 lockable 相关配置，在这个文件里 `config/initializers/devise.rb`
3. rails g migration add_lockable_to_devise
```ruby
class AddLockableToDevise < ActiveRecord::Migration
  def change
    add_column :users, :failed_attempts, :integer, default: 0, null: false # Only if lock strategy is :failed_attempts
    add_column :users, :locked_at, :datetime

    # Add these only if unlock strategy is :email or :both
    add_column :users, :unlock_token, :string
    add_index :users, :unlock_token, unique: true
  end
end
``` 

4. rails generate devise:views users
5. rake db:migrate
