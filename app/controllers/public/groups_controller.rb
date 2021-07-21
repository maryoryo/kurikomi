class Public::GroupsController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @groups = Group.all.page(params[:page]).per(10)
  end

  def show
    @group = Group.find(params[:id])
    @group_posts = @group.group_posts.page(params[:page]).per(10)
  end

  def join
    @group = Group.find(params[:group_id])
    @group.users << current_user
    redirect_to  group_path(@group)
  end

  def unjoin
    @group = Group.find(params[:group_id])
    @group.users.delete(current_user)
    redirect_to groups_path
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.users << current_user
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
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group)
    else
      render 'edit'
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:notice] = "グループ削除しました。"
    redirect_to groups_path
  end
  
  #グループに紐づいたメンバーの一覧
  def members
    @group = Group.find(params[:group_id])
    @group_members = @group.users.page(params[:page]).per(10)
  end
  
  def hashtag
    @user = current_user
    @tag = Hashtag.find_by(name: params[:name])
    @groups = @tag.groups.page(params[:page]).per(10)
  end


  private

  def group_params
    params.require(:group).permit(:name, :introduction, :group_image, :genre, :hashbody, hashtag_ids: [])
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end
end
