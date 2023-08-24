class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order_items = OrderItem.where(order_id: params[:id])
    @order = Order.find(params[:id])
  end
  
  def update
  @order = Order.find(params[:id])
  @order_items = OrderItem.where(order_id: params[:id])
  if @order.update(order_params)
    @order_items.update_all(making_status: 1) if @order.status == "payment_confirmation"
    ## ①注文ステータスが「入金確認」とき、製作ステータスを全て「製作待ち」に更新する
  end
  redirect_to admin_order_path(@order)
  end

private
  def order_params
  params.require(:order).permit(:status)
  end

end
