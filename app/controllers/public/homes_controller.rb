class Public::HomesController < ApplicationController

  def top
    @genres = Genre.all
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true).page(params[:page]).per(6)
    @new_items = Item.first(6)
  end

  def about
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true).page(params[:page]).per(6)
    @new_items = Item.first(6)
  end

end
