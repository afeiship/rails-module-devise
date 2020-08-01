# role
- https://github.com/heartcombo/devise/wiki/How-To:-Add-an-Admin-Role

## steps
1. 添加 migration
```ruby
rails g migration AddRoleToUsers role:integer
```
2. 详细的值
```ruby
class User < ApplicationRecord
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  # ...
end
```
3. 调用
```ruby
user.admin?
user.admin!
user.role
user.user?
user.vip?
```


## other solution
- 可以建一个 user_roles 表
- id: role_id
- code: role_code(user/vip/admin)
- name: role_name(普通用户/月卡用户/管理员)
- description:(普通的互联网用户/月卡用户/超级管理员)
