class LeadPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def edit?
    user.has_role? :admin or user.has_role? :BusinessDeveloper
  end

  def destroy?
    user.has_role? :admin or user.has_role? :BusinessDeveloper
  end

  def new?
    user.has_role? :admin or user.has_role? :BusinessDeveloper  
  end
  
end
