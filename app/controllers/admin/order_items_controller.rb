class Admin::OrderItemsController < ApplicationController
  def update
    @order_item = OrderItem.find(params[:id])
    @order = @order_item.order
    @order_item = @order.order_item
    @order_item.update(order_item_params)
    @making_statuses = @order_item.pluck(:making_status)
    @order.update(status: "making") if @making_statuses.any?{|val| val == "making" }
    @order.update(status: "standby") if @making_statuses.all?{|val| val ==  "finish"}

    redirect_to admin_order_path(@order)

    if @order_item.errors.any?
      flash[:alert] = "製作ステータスが更新できませんでした。"
    else
      flash[:notice] = "製作ステータスを更新しました。"
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:making_status)
  end
end
