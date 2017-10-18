class CollaboratorPolicy < ApplicationPolicy
  def destroy?
    if user != nil
      return user.owns?(record) ||  user.admin?
    end
    return false
  end
  
  class Scope < Scope
    def resolve
      scope
    end
  end
end
