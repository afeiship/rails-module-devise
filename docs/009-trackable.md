# trackable

## steps
1. 添加 `trackable`
```ruby
devise :registerable, :trackable
```
2. migration
```ruby
rails g migration add_trackable_to_devise
```

3. migrations detail
```ruby
class AddTrackableToDevise < ActiveRecord::Migration
  def up
    add_column :users, :sign_in_count, :integer, default: 0, null: false
    add_column :users, :current_sign_in_at, :datetime
    add_column :users, :last_sign_in_at, :datetime
    add_column :users, :current_sign_in_ip, :inet
    add_column :users, :last_sign_in_ip, :inet
  end

  def down
    remove_columns :users, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip
  end
end
```

4. rake db:migrate
