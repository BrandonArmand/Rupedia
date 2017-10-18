class WikisController < ApplicationController
   before_action :authorize_user, except: [:index, :show]
   
  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
    @collaborators = @wiki.collaborators.all
    @collab_users = []
    @collaborators.each do |f|
      @collab_users << User.find(f.user_id)
    end
  end

  def new
    @wiki = Wiki.new
  end
  
  def create
    @wiki = current_user.wikis.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    if current_user.premium_permission?
      @wiki.private = params[:wiki][:private]
    else
      @wiki.private = false;
    end
    @wiki.user = current_user 
    
    if @wiki.save
      redirect_to @wiki
    else
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end
  
   def update
     @wiki = Wiki.find(params[:id])
     
     authorize @wiki
     @wiki.title = params[:wiki][:title]
     @wiki.body = params[:wiki][:body]
     if current_user.premium_permission?
      @wiki.private = params[:wiki][:private]
     else
      @wiki.private = false;
     end
  
     if @wiki.save
       redirect_to @wiki
     else
       render :edit
     end
   end  
  
  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.destroy
      redirect_to wikis_path
    else
      redirect_to wiki(params[:id])
    end
  end
  
end
