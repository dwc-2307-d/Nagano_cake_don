class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_cart_item, only: [:update,:destroy]

  def index
    @cart_items = current_customer.cart_items
  end


  def create
    item = Item.find(params[:cart_item][:item_id])
    
    unless item.is_status
      flash[:alert] = "選択された商品は現在販売停止中です。"
      redirect_to request.referer
      return
    end
    
    existing_cart_item = current_customer.cart_items.find_by(item: item)
  
    if existing_cart_item
      new_quantity = existing_cart_item.quantity + cart_item_params[:quantity].to_i
      existing_cart_item.update(quantity: new_quantity)
      redirect_to cart_items_path, notice: 'カートに商品を追加しました'
    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
  
      if @cart_item.save
        redirect_to cart_items_path, notice: 'カートに商品を追加しました'
      else
        # 個数を選択せずにカートに追加しようとした場合
        @genres = Genre.all
        @item = Item.find_by(id: @cart_item.item_id)
        flash.now[:alert] = '※個数を選択してください'
        render "items/show"
      end
    end
  end

  def update
    new_quantity = params[:cart_item][:quantity].to_i
    if @cart_item.update(quantity: new_quantity)
      redirect_to cart_items_path, notice: '変更を更新しました'
    else
      flash.now[:alert] = '変更の更新に失敗しました'
      render :index
    end
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
