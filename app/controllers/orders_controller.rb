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
    @orders = Order.all
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
