class Public::GroupsController < ApplicationController
  
  
  
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
    @group = Group.new(group_params)
    if @group.save
      redirect_to group_path(@group)
    else
      render 'new'
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
  end
  
  
  private
  
  def group_params
    params.require(:group).permit(:name, :introduction, :group_image)
  end
end
