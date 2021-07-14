class Admin::GroupsController < ApplicationController
  
  before_action :authenticate_admin!
  
  
  def index
    @groups = Group.all 
  end

  def show
    @group = Group.find(params[:id])
    @group_posts = @group.group_posts
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new
    
  end

  def edit
  end

  def update
  end
  
  def destroy
  
    
  end
end
