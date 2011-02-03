class SocialAbility
# stuff like class AbilityDecorator goes here
  include CanCan::Ability

  def initialize(user)

    can :create, UserAuthentication do
      !user.new_record?
    end

    can :destroy, UserAuthentication do |user_authentication|
      user_authentication.user == user
    end

    can :read, User do |resource, token|
      resource == user || resource.token && token == resource.token
    end

    can :update, User do |resource, token|
      resource == user || resource.token && token == resource.token
    end
  end
end


