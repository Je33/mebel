# encoding: utf-8
class AjaxController < ApplicationController

  before_filter :get_basket

  def add_to_basket
    res = {:success => false}
    if params[:product_id].to_i > 0 and @order.present?
      if @order.new_record?
        @order = Order.create({:session => session[:session_id], :status => 0, :user_id => user_signed_in? ? current_user.id : 0})
      end
      item = Product.find params[:product_id]
      if item.present?
        cnt = 1
        price = item.price.to_i
        kind_main_id = 0
        kind_opt_id = 0
        if params[:product_cnt].to_i > 0
          cnt = params[:product_cnt].to_i
        end
        if params[:product_kind_main].to_i > 0
          kind_main_id = params[:product_kind_main].to_i
          kind_main = Kind.find(kind_main_id)
          texture_link = item.product_textures.where(:texture_id => kind_main.texture_id)
          if texture_link.price.to_i > 0
            price = texture_link.price.to_i
          end
        end
        if params[:product_kind_opt].to_i > 0
          kind_opt_id = params[:product_kind_opt].to_i
          kind_opt = Kind.find(kind_opt_id)
          texture_opt_link = item.product_textures.where(:texture_id => kind_opt.texture_id)
          if texture_opt_link.price.to_i > 0 and texture_opt_link.price.to_i >= price
            price = texture_opt_link.price.to_i
          end
        end
        l = Basket.where({:order_id => @order.id, :product_id => item.id, :price => price, :kind_main => kind_main_id, :kind_opt => kind_opt_id}).first_or_create
        out = l.cnt.to_i + cnt.to_i
        l.update_attribute :cnt, l.cnt.to_i + cnt.to_i
        res = {:success => true, :col => out, :cnt => @order.cnt, :price => (out * item.price.to_f).round(2), :summ => @order.sum.round(2)}
      end
    end
    render :json => res
  end

  def remove_from_basket
    res = {:success => false}
    if params[:product_id].to_i > 0 and @order.present?
      item = Product.find params[:product_id]
      if item.present?
        cnt = 1
        if params[:product_cnt].to_i > 0
          cnt = params[:product_cnt]
        end
        l = Basket.where({:order_id => @order.id, :product_id => item.id}).first
        out = l.cnt.to_i - cnt.to_i > 0 ? l.cnt.to_i - cnt.to_i : 1
        l.update_attribute :cnt, out
        res = {:success => true, :col => out, :cnt => @order.cnt, :price => (out.to_i * item.price.to_f).round(2), :summ => @order.sum.round(2)}
      end
    end
    render :json => res
  end

  def destroy_basket
    res = {:success => false}
    if params[:basket_id].to_i > 0
      basket = Basket.find(params[:basket_id])
      if basket.present?
        basket.destroy
        res = {:success => true, :summ => @order.sum.round(2)}
      end
    end
    render :json => res
  end

end