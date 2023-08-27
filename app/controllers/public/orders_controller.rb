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
    @orders = current_customer.orders.order("created_at desc")
    @genres = Genre.all
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def confirm
    @order = Order.new(order_params)
    if params[:select_address] == "0"
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.full_name
    elsif params[:select_address] == "1"
      @address = Address.find(params[:address_id])
      @order.post_code = @address.post_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:select_address] == "2"
      @order.customer_id = current_customer.id
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
    params.require(:order).permit(:payment_method, :post_code, :address, :name, :total_amount, :shipping_fee)
  end

end
