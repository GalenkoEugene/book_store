class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, :all
    can :create, Review, user_id: user.id
    can %i[create update], Order, user_id: user.id
    can %i[create update], OrderItem, user_id: user.id
    can %i[create update], Address, user_id: user.id
    can %i[create update], CreditCard, user_id: user.id
  end
end
