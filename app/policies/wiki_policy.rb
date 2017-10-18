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
    wiki.private? != true || user.owns?(wiki) || user.collab_wikis.ids.include?(wiki.id) ||  user.admin?
  end
  
  def private_wiki?
    user.owns?(wiki) && user.premium? || user.admin?
  end
  
  class Scope < Scope
    attr_reader :user, :scope
 
     def initialize(user, scope)
       @user = user
       @scope = scope
     end
 
     def resolve
       wikis = []
       if user != nil
           if user.role == 'admin'
             wikis = scope.all
           elsif user.role == 'premium'
             all_wikis = scope.all
             all_wikis.each do |wiki|
               if !wiki.private? || user.owns?(wiki) || user.collab_wikis.ids.include?(wiki.id)
                 wikis << wiki
               end
             end
           else
             all_wikis = scope.all
             wikis = []
             all_wikis.each do |wiki|
               if !wiki.private? || user.collab_wikis.ids.include?(wiki.id)
                 wikis << wiki
               end
             end
           end
        else
          all_wikis = scope.all
          wikis = []
          all_wikis.each do |wiki|
            if !wiki.private?
              wikis << wiki
            end
          end
       end
       wikis
     end
  end
end
