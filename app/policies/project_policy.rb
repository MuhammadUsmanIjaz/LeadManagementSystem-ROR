class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def destroy?
    user.has_role? :admin
  end

  def addmanagers?
    user.has_role? :admin or user.has_role? :BusinessDeveloper
  end
end
