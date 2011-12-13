class Spree::SocialAbility
# stuff like class AbilityDecorator goes here
  include CanCan::Ability

  def initialize(user)

    can :create, Spree::UserAuthentication do
      !user.new_record?
    end

    can :destroy, Spree::UserAuthentication do |user_authentication|
      user_authentication.user == user
    end

    can :read, Spree::User do |resource, token|
      resource == user || resource.token && token == resource.token
    end

    can :update, Spree::User do |resource, token|
      resource == user || resource.token && token == resource.token
    end
  end
end


