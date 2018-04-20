class OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      redirect_to orders_path
    else
      render :new
    end

  end

  def index
    if params[:filter] && params[:filter] != ""
      @orders = Order.filter_by_status(params[:filter]).order("shipped_date")
    else
      @orders = Order.where("status != 'Delivered'")
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :order_number,
      :tracking_number,
      :address,
      :vendor_id,
      :buyer_id
    )
  end

end
