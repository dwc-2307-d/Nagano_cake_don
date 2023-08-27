class Public::GenresController < ApplicationController
  def show
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    @paginated_items = @genre.items.page(params[:page]).per(6)
  end
end
