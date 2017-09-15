class AdminAbility
  include CanCan::Ability

  def initialize(user)
    user ||= Adminser.new
    can :manage, :all
    cannot :update, Order, order_status_id: OrderStatus.where(name: %i[in_progress in_queue]).ids
  end
end
