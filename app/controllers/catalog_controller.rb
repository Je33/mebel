class CatalogController < ApplicationController

  def index
    @categories = Category.all
  end

  def category
    @products = Category.find(params[:category_id]).products
  end

  def product
    @product = Product.find(params[:product_id])
  end

  def list
  end
end
