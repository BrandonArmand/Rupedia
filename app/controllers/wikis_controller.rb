class WikisController < ApplicationController
  before_action :authorize_user, except: [:index, :show]
  before_action :confirm_access, except: [:index, :new, :create, :show]
  
  
  
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end
  
  def create
    @wiki = current_user.wikis.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    @wiki.user = current_user 
    
    if @wiki.save
      redirect_to @wiki
    else
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end
  
   def update
     @wiki = Wiki.find(params[:id])
 
     @wiki.title = params[:wiki][:title]
     @wiki.body = params[:wiki][:body]

     if @wiki.save
       redirect_to @wiki
     else
       render :edit
     end
   end  
  
  def destroy
    @wiki = Wiki.find(params[:id])
    
    if @wiki.destroy
      redirect_to wikis_path
    else
      redirect_to wiki(params[:id])
    end
  end
  
  
  def confirm_access
    wiki = Wiki.find(params[:id])
    if (wiki.private? == false || current_user.owns?(wiki) || current_user.admin?)
      true
    else
      redirect_to wiki
    end
  end
  
end
