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
    order = Order.new(order_params)
    order.save
    @cart_items = current_customer.cart_items.all
    @cart_items.each do |cart_item|
      @order_details = OrderDetail.new
      @order_details.order_id = order.id
      @order_details.item_id = cart_item.item.id
      @order_details.price = cart_item.item.price_excluding_tax
      @order_details.number = cart_item.amount
      @order_details.manufacture_status = 0
      @order_details.save!
    end
    CartItem.destroy_all
    redirect_to orders_completed_path
  end

  def index
    @orders = Order.all.order("created_at desc")
    @orders = current_customer.orders.order("created_at desc")
    @genres = Genre.all
  end

  def show
    def show
      @order_details = OrderDetail.where(order_id: params[:id])
      @order = Order.find(params[:id])
    end
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:select_address] == "0"
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:select_address] == "1"
       @address = Address.find(params[:order][:address_id])
       @order.post_code = @address.post_code
       @order.address = @address.address
       @order.name = @address.name
    elsif params[:order][:select_address] == "2"
      @order.customer_id = current_customer.id
    end
      @cart_items = current_customer.cart_items
      @order_new = Order.new
      render :confirm
  end

  def complete
    @genres = Genre.all
  end


  private

  def order_params
    params.require(:order).permit(:payment_method, :post_code, :address, :name, :postage, :amount_requested, :customer_id , :order_status)
  end

end
