class Public::GroupsController < ApplicationController
  
  
  
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
  end
end
