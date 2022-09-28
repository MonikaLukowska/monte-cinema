class MoviePolicy < ApplicationPolicy
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
    new?
  end

  def create?
    manager?
  end

  def update?
    manager?
  end

  def destroy?
    update?
  end

  private

  def manager?
    user.manager?
  end
end
