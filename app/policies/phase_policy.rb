class PhasePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    user.has_role? :admin or user.has_role? :BusinessDeveloper
  end

  def edit?
    user.has_role? :admin or user.has_role? :BusinessDeveloper
  end

  def destroy?
    user.has_role? :admin or user.has_role? :BusinessDeveloper
  end

  def addengineers?
    user.has_role? :admin or user.has_role? :TechnicalManager
  end

end
