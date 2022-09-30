class ReservationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.manager?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end

  def show?
    manager? || permitted_client?
  end

  def new?
    true
  end

  def create?
    true
  end

  def confirm?
    manager?
  end

  def cancel?
    manager? || permitted_client?
  end

  private

  def manager?
    user.manager?
  end

  def permitted_client?
    record.user_id == user.id
  end
end
