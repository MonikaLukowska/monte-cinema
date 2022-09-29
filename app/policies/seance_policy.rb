class SeancePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def new?
    manager?
  end

  def edit?
    manager?
  end

  def create?
    manager?
  end

  def update?
    manager?
  end

  def destroy?
    manager?
  end

  private

  def manager?
    user.manager?
  end
end
