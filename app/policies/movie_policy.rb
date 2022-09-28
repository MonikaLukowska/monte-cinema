class MoviePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  %i[new? edit? create? update? destroy?].each do |method|
    define_method(method) { manager? }
  end

  private

  def manager?
    user.manager?
  end
end
