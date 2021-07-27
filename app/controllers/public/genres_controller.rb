class Public::GenresController < ApplicationController
  
  before_action :authenticate_user!
  
  def index
    @genres = Genre.all
  end

  def show
    @genre = Genre.find(params[:id])
    @groups = @genre.groups.page(params[:page]).per(10)
  end
end
