module WikiHelper
    def authorize_current_user?
        wiki = Wiki.find(params[:id])
        if (wiki.private? == false || current_user.owns?(wiki) || current_user.admin?)
          true
        else
          false
        end
    end
    
    def delete?
        wiki = Wiki.find(params[:id])
        if (current_user.owns?(wiki) || current_user.admin?)
          true
        else
          false
        end
    end
    
    def private_permission?
        wiki = Wiki.find(params[:id])
        if (current_user.owns?(wiki) && current_user.premium? || current_user.admin?)
          true
        else
          false
        end
    end
end
