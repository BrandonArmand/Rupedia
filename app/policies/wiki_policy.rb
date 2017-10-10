class WikiPolicy < ApplicationPolicy
  
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end
  
  def destroy?
    user.owns?(wiki) || user.admin?
  end
  
  def update?
    wiki.private? != true || user.owns?(wiki) || user.admin?
  end
  
  def private_wiki?
    user.owns?(wiki) && user.premium? || user.admin?
  end
  
  class Scope < Scope
    def resolve
      scope
    end
  end
end
