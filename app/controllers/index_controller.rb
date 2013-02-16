class IndexController < ApplicationController

  def index
    @categories = Category.includes(:products).all
    @specials = Special.all
    @sales = Product.sales.includes(:photos).all
    @news = Product.news.includes(:photos).all
  end

end
