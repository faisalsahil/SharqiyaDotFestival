
roles_array=['Super Admin', 'App User']

if Role.all.blank?

  roles_array.each do |role|
    Role.create!(name: role)
  end
end

if User.all.blank?

  user = User.new
  user.first_name            = 'Super'
  user.last_name             = 'amdin'
  user.username              = 'superadmin'
  user.email                 = 'admin@gmail.com'
  user.password              = '123456'
  user.password_confirmation = '123456'
  user.phone                 = '123456'
  user.save
  user.add_role(AppConstants::SUPER_ADMIN)
end
