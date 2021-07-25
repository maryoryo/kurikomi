class Admin::SearchsController < ApplicationController
  
  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    if @model == "user"
      @records = User.search_for(@content, @method).page(params[:page]).per(10)
    elsif @model == "group"
      @records = Group.search_for(@content, @method).page(params[:page]).per(10)
    else
      @records = Genre.search_for(@content, @method)
    end
  end
  
end
