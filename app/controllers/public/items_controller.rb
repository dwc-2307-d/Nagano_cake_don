class Public::ItemsController < ApplicationController
  
  def index 
    @items = Item.page(params[:page]).per(5)
    @items_all = Item.all
  end
  
end