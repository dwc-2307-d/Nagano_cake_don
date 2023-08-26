class Public::ItemsController < ApplicationController
   before_action :set_q, only: [:index, :search]

  def index
    @genres = Genre.all

    if params[:q]
      @search = Item.ransack(params[:q])
      @items = @search.result(distinct: true).page(params[:page]).per(6)
    else
      @items = Item.page(params[:page]).per(6)
    end

    @items_all = Item.all
  end
  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
  end

  def search
    @items = @q.result(distinct: true).page(params[:page]).per(6)
    @genres = Genre.all
    @items_all = Item.all
    render :index
  end

   private

  def set_q
    @q = Item.ransack(params[:q])
  end


end