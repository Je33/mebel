# encoding: utf-8
class AdminController < ApplicationController

  layout "admin"
  before_filter :authenticate_user!

  def index
    @breads = [['Администрирование', '/admin'], ['Заказы']]
    @orders = Order.where("status > 0").order(:status).page params[:page]
  end

  def order
    if params[:order]
      @ord = Order.find(params[:order_id])
      @ord.update_attributes params[:order]
    end
    @ord = Order.find(params[:id])
  end

end
