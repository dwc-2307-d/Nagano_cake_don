class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @addresses = Address.all
    @customer = current_customer
    if current_customer.cart_items.empty?
      flash[:notice] = "カート内に商品が入っておりません。商品を追加してください。"
      redirect_to items_path
    else
      @order = Order.new
    end
  end

  def create
  cart_items = current_customer.cart_items
  @order = current_customer.orders.new(order_params)

    if @order.save
      cart_items.each do |cart|
        order_item = OrderItem.new(
          item_id: cart.item_id,
          order_id: @order.id,
          quantity: cart.quantity,
          tax_price: cart.item.with_tax_price
        )
        order_item.save
      end
      cart_items.destroy_all
      redirect_to complete_orders_path
    else
      redirect_to new_order_path, notice: "支払い方法・配送先を選択してください。"
    end
  end

  def index
    @orders = Order.all.order("created_at desc")
    @orders = current_customer.orders.order("created_at desc")
    @genres = Genre.all
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def confirm
    @customer = current_customer
    @cart_items = @customer.cart_items
    @order = Order.new(order_params)
    @order.post_code = @customer.post_code
    @order.address = @customer.address
    @order.name = @customer.full_name

    if params[:order][:select_address] == "0"
      # 自身の住所を設定する処理
      @order.post_code = @customer.post_code
      @order.address = @customer.address
      @order.name = @customer.full_name
    elsif params[:order][:select_address] == "1"
      # 登録済み住所を設定する処理
      @address = Address.find(params[:order][:address_id])
      @order.post_code = @address.post_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:select_address] == "2"
      # カスタマー情報を設定する処理
      @order.post_code = params[:order][:post_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end

    # カート内の商品を取得
    @cart_items = current_customer.cart_items
    @order_new = Order.new

  end

  def complete
    @genres = Genre.all
  end


  private

  def order_params
    params.require(:order).permit(:customer_id, :payment_method, :post_code, :address, :name, :total_amount, :shipping_fee)
  end

end
