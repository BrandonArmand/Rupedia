class CollaboratorsController < ApplicationController
  def new
    @collaborator = Wiki.find(params[:id]).collaborators.new
  end
  
  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = @wiki.collaborators.new
    @user = params[:collaborator][:user]
    if User.find_by_email(@user) != nil
      @collaborator.user_id = User.find_by_email(@user).id
      if !User.find(@collaborator.user_id).collab_wikis.include?(@wiki)
        if User.find_by_email(@user) != current_user
          @collaborator.save
          redirect_to edit_wiki_url(params[:wiki_id]), :alert => "User was added"
        else
          redirect_to edit_wiki_url(params[:wiki_id]), :alert => "You are already a Collaborator"
        end
      else
        redirect_to edit_wiki_url(params[:wiki_id]), :alert => "User is already a Collaborator"
      end
    else
      redirect_to edit_wiki_url(params[:wiki_id]), :alert => "User does not exist"
    end
  end
  
  def destroy
    @user = params[:id]
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = @wiki.collaborators.find_by_user_id(@user)
    authorize @collaborator
    if @collaborator.destroy
      redirect_to @wiki
    end
  end
end
