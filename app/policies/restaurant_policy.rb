class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      # scope -> is Restaurant
      # scope.all -> behaves like Restaurant.all, every user can see all restaurants
      user.admin? ? scope.all : scope.where.not(user: user)
    end
  end

  # INSIDE PUNDIT POLICIES
  # To access the current_user, we just use user
  # user -> is the current_user
  # record -> is a restaurant

  def show?
    true
  end

  def new?
    create?
  end

  def create?
    true
  end

  def edit?
    update?
  end

  def update?
    # Only owner of the restaurant can perform update
    # record is the restaurant
    # user is the current_user
    record.user == user
  end

  def destroy?
    record.user == user
  end
end
