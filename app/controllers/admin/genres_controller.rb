class Admin::GenresController < ApplicationController
  
  before_action :authenticate_admin!
  
  def index
    @genres = Genre.all.page(params[:page]).per(10)
    @genre = Genre.new
  end
  
  def show
    @genre = Genre.find(params[:id])
    @groups = @genre.groups.page(params[:page]).per(10)
  end
  
  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path
    else
      render 'index'
    end
  end
  
  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genre_path(@genre)
    else
      render 'index'
    end
  end
  
  def destroy
    genre = Genre.find(params[:id])
    genre.destroy
    redirect_to admin_genres_path
  end
  
  
  private
  
  def genre_params
    params.require(:genre).permit(:name)
  end
  
end
