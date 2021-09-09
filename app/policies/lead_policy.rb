class LeadPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def edit?
    user.has_role? :admin or user.has_role? :BusinessDeveloper and user.id == record.user_id
  end

  def destroy?
    user.has_role? :admin or user.has_role? :BusinessDeveloper and user.id == record.user_id
  end

  def new?
    user.has_role? :admin or user.has_role? :BusinessDeveloper  
  end
  
end
