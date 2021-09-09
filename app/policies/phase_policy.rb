class PhasePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    user.has_role? :admin or user.has_role? :BusinessDeveloper and user.id == Lead.find(record.lead_id).user_id
  end

  def edit?
    user.has_role? :admin or user.has_role? :BusinessDeveloper or user.has_role? :TechnicalManager
  end

  def destroy?
    user.has_role? :admin or user.has_role? :BusinessDeveloper
  end

  def addengineers?
    user.has_role? :admin or user.has_role? :TechnicalManager
  end

  def respond?
    user.has_role? :TechnicalManager
  end
end
