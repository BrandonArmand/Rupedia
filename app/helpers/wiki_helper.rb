module WikiHelper
    def authorize_current_user?
        current_user && @wiki.user == current_user
    end
end
