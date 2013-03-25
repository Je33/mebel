# encoding: utf-8
class Admin::AjaxController < AdminController

  def status
    if params[:id] and params[:status]
      order = Order.find(params[:id])
      order.update_attribute :status, params[:status]
      render :json => {:success => true, :status => order.status}
    else
      render :json => {:success => false}
    end
  end

  def users
    #User.find_by_email("maskin.sergey@gmail.com").destroy
    render :json => User.all
  end

  def textures

  end

end