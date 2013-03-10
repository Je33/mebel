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
      ord = Order.find(params[:order_id])
      ord.update_attributes params[:order]
      redirect_to "/admin/orders/#{order.id}"
    end
    if params[:order_add_item].to_i > 0
      item_id = params[:order_add_item].to_i
      item = Product.find(item_id)
      order = Order.find(params[:id])
      cnt = 1
      price = item.price.to_i
      kind_main_id = 0
      kind_opt_id = 0
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
      l = Basket.where({:order_id => order.id, :product_id => item.id}).first_or_create
      out = l.cnt.to_i + cnt.to_i
      l.update_attributes({
        :cnt => out,
        :price => out * price,
        :kind_main => kind_main_id,
        :kind_opt => kind_opt_id
      })
      redirect_to "/admin/orders/#{order.id}"
    end
    if params[:order_remove_item].to_i > 0
      item_id = params[:order_remove_item].to_i
      item = Product.find(item_id)
      order = Order.find(params[:id])
      price = item.price.to_i
      kind_main_id = 0
      kind_opt_id = 0
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
      if item.present?
        cnt = 1
        if params[:product_cnt].to_i > 0
          cnt = params[:product_cnt]
        end
        l = Basket.where({:order_id => order.id, :product_id => item.id}).first
        out = l.cnt.to_i - cnt.to_i > 0 ? l.cnt.to_i - cnt.to_i : 1
        l.update_attributes({
          :cnt => out,
          :price => out * price
        })
      end
      redirect_to "/admin/orders/#{order.id}"
    end
    if params[:order_remove_basket].to_i > 0
      basket = Basket.find(params[:order_remove_basket])
      order = Order.find(params[:id])
      if basket.present?
        basket.destroy
      end
      redirect_to "/admin/orders/#{order.id}"
    end
    @ord = Order.find(params[:id])
  end

end
