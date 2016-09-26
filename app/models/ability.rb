class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new
    if user.has_role? :super_admin
      can :manage, :all
      can :access, :rails_admin
      can :dashboard
    end

  end

end
