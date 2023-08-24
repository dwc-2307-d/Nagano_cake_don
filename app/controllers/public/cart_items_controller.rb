class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_cart_item, only: [:destroy]

  def index
    @cart_items = current_customer.cart_items
  end


  def create

    item = Item.find(params[:cart_item][:item_id])
    existing_cart_item = current_customer.cart_items.find_by(item: item)
    

    if existing_cart_item
      existing_cart_item.increment!(:quantity)
    else
      new_cart_item = current_customer.cart_items.build(item: item, quantity: 1)
      new_cart_item.save
    end

    redirect_to cart_items_path, notice: '商品を追加しました'
  end

  def update
    cart_item = CartItem.find(params[:id])
    new_quantity = params[:quantity].to_i
    cart_item.update(quantity: new_quantity)
    redirect_to cart_items_path, notice: '変更を更新しました'
  end

  def destroy
    @cart_item.destroy
    redirect_to request.referer, notice: '商品を削除しました'
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path, notice: 'カート内商品を全て削除しました'
  end

  private
  
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :quantity)
  end

  def set_cart_item
    @cart_item = current_customer.cart_items.find(params[:id])
  end

end
