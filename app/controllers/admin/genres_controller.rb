class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path
    else
      @genres = Genre.all
      flash.now[:alert] = @genre.errors.full_messages.join(",")
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre=Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path
    else
      flash.now[:alert] = @genre.errors.full_messages.join(",")
      render :edit
    end
  end

private

  def genre_params
     params.require(:genre).permit(:name)
  end

end
