class CatalogController < ApplicationController

  def index
    @categories = Category.all
  end

  def category
    @category = Category.find(params[:category_id])
    @products = @category.products
  end

  def product
    @product = Product.find(params[:product_id])
  end

  def list

  end

  def ajax_category
    @category = Category.find(params[:cat])
    props = []
    if !params[:vals].blank?
      params[:vals].each do |v|
        props << "text like '%#{v}%'"
      end
    end
    @products = @category.products.where(props.join(" OR "))
    render :layout => false
  end
end
