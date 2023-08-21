class Public::HomesController < ApplicationController

  def top
    items = Item.all
    @new_items = items.first(4)
    @genres = Genre.all
  end

  def about
  end

end
