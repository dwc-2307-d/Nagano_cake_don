class Public::ItemsController < ApplicationController
  
  def index 
    @items = Item.page(params[:page]).per(6)
    @genres = Genre.all
    @items_all = Item.all
  end
  
  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
  end
  
end