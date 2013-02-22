# encoding: utf-8
class AjaxController < ApplicationController

  def add_to_basket
    res = {:success => false}
    if params[:product_id].to_i > 0 and @order.present?
      item = Product.find params[:product_id]
      if item.present?
        cnt = 1
        if params[:product_cnt].to_i > 0
          cnt = params[:product_cnt].to_i
        end
        l = Basket.where({:order_id => @order.id, :product_id => item.id}).first_or_create
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