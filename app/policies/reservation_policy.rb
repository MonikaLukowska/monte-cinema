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
    client?
  end

  def create_at_desk?
    manager?
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

  def client?
    user.client?
  end

  def permitted_client?
    record.user_id == user.id
  end
end
