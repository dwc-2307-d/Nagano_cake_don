class Admin::OrderItemsController < ApplicationController
  def update
    @order_item = OrderItem.find(params[:id])
    @order = @order_item.order
    @order_items = @order.order_items
    @order_item.update(order_item_params)
    @making_statuses = @order.order_items.pluck(:making_status)
    @order.update(status: "making") if @making_statuses.any?{|val| val == "manufacturing" }
    @order.update(status: "preparing_ship") if @making_statuses.all?{|val| val ==  "finish"}



    if @order_item.errors.any?
      flash[:alert] = "製作ステータスが更新できませんでした。"
    else
      flash[:notice] = "製作ステータスを更新しました。"
    end

    redirect_to admin_order_path(@order)
  end

  private

  def order_item_params
    params.require(:order_item).permit(:making_status)
  end
end
