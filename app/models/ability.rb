require 'cancan'

class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, Document do |document|
      if not document.user
        false
      else
        document.user.id == user.id
      end
    end

    can :manage, Car do |car|
      if not car.user
        false
      else
        car.user.id == user.id
      end
    end

    can :view, [Document, Car]
  end
end
