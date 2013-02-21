# encoding: utf-8
class AjaxController < ApplicationController

  def add_to_basket
    res = {:success => false}
    if params[:product_id].to_i > 0 and @order.present?
      item = Product.find params[:product_id]
      if item.present?
        cnt = 1
        if params[:product_cnt].to_i > 0
          cnt = params[:product_cnt]
        end
        l = Basket.first_or_create({:order_id => @order.id, :product_id => item.id})
        l.update_attribute :cnt, cnt
        res = {:success => true, :sum => s, :cnt => c}
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
        l = Basket.where({:order_id => @order.id, :product_id => item.id})
        l.update_attribute :cnt, cnt
        res = {:success => true, :sum => s, :cnt => c}
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
        res = {:success => true}
      end
    end
  end

end