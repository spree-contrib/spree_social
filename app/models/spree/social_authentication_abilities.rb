class Spree::SocialAuthenticationAbilities
  include CanCan::Ability

  def initialize(user)
    if user.respond_to?(:has_spree_role?) && user.has_spree_role?('admin')
      can :manage, Spree::SocialConfiguration
    end
  end
end
