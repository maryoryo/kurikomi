class Admin::GenresController < ApplicationController
  def index
    @genres = Genre.all
  end
  
  def show
    @genre = Genre.find(params[:id])
  end
  
  def new
    @genre = Genre.new
  end
  
  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path
    else
      render 'new'
    end
  end

  def edit
  end
  
  def destroy
    
  end
  
  
  private
  
  def genre_params
    params.require(:genre).permit(:name)
  end
  
end
