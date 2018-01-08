class Ability
  include CanCan::Ability
  
  def initialize(user)
    unless user.nil?
      role = user.roles.last.name

      if role == AppConstants::SUPER_ADMIN
        super_admin user
      end

    end
  end

  protected

    def super_admin(user)
      can :manage, :all
    end
end
