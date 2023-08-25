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
     if @order.status == "payment_confirmation"
    @order_items.update_all(making_status: 1)
    ## ①注文ステータスが「入金確認」とき、製作ステータスを全て「製作待ち」に更新する
 　　 end
  redirect_to admin_order_path(@order)
  end
  end

private
  def order_params
    params.require(:order).permit(:making_status)
  end

end
