class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_cart_item, only: [:update,:destroy]

  def index
    @cart_items = current_customer.cart_items
  end


  def create

    item = Item.find(params[:cart_item][:item_id])
    existing_cart_item = current_customer.cart_items.find_by(item: item)

    if @cart_item
      new_quantity = @cart_item.quantity + cart_item_params[:quantity].to_i
      @cart_item.update(quantity: new_quantity)
      redirect_to cart_items_path, notice: 'カートに商品を追加しました'
    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id = current_customer.id

      if @cart_item.save
        redirect_to cart_items_path, notice: 'カートに商品を追加しました'
      else
        session[:cart_item] = @cart_item.attributes.slice(*cart_item_params.keys)
        @genres = Genre.all
        @item = Item.find_by(id: @cart_item.item_id)
        redirect_to item_path(@item.id), flash: { alert: '※個数を選択してください' }
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
