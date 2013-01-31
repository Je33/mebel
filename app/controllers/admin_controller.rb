# encoding: utf-8
class AdminController < ApplicationController

  layout "admin"
  before_filter :authenticate_user!

  def index
    @breads = [['Администрирование', '/admin'], ['Заказы', '/admin']]
    @orders = Order.order(:status).page params[:page]
  end

end
