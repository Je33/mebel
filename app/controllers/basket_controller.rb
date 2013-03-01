class BasketController < ApplicationController

  def index
  end

  def order
  end

  def go
    if params[:order]
      @ord = Order.find(params[:order_id])
      params[:order][:status] = 10
      @ord.update_attributes params[:order]
    end
  end

end