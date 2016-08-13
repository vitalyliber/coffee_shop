class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new
    if user.has_role? :admin
      can :manage, :all
      can :access, :rails_admin
      can :dashboard
    elsif user.has_role? :barman
      can :manage, Order
    end

  end

end
