class Admin::GroupsController < ApplicationController
  
  before_action :authenticate_admin!
  
  
  def index
    @groups = Group.all 
  end

  def show
    @group = Group.find(params[:id])
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
