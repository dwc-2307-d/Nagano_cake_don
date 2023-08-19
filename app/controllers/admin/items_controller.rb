class Admin::ItemsController < ApplicationController
  
  def inde
  end
  
  def new
    @item = Item.new
    @genres = Genre.pluck(:name, :id)
  end
  
  def show
    @item = Item.find(params[:id])
  end
  
  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_item_path(@item)
  end

  def edit
  end

  def update
  end

  private 
  
  def item_params
    params.require(:item).permit(:name, :description, :price, :is_status, :image, :genre_id)
  end
  
end
