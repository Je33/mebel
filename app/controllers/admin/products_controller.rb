# encoding: utf-8
class Admin::ProductsController < AdminController

  before_filter :breadcrumbs

  def breadcrumbs
    @company = Company.find params[:company_id]
    @breads = [['Администрирование', '/admin'],
               ['Компании', '/admin/companies'],
               [@company.name, edit_admin_company_path(@company)]]
  end

  def index
    @breads << ['Товары']
    @products = @company.products.order("id desc").page params[:page]
  end

  def new
    @breads << ['Товары', admin_company_products_path(@company)]
    @breads << ['Новый товар']
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
    @breads << ['Товары', admin_company_products_path(@company)]
    @breads << ["Редактирование товара - #{@product.name}"]
  end

  def create
    @product = Product.new params[:product]
    @product.company_id = @company.id
    if @product.save
      if params[:product_photo]
        params[:product_photo].each do |f|
          file = Photo.create({:product_id => @product.id, :file => f})
        end
      end
      flash.now[:notice] = "Товар успешно создан"
      if params[:apply]
        redirect_to edit_admin_company_product_path(@company, @product)
      else
        redirect_to admin_company_products_path(@company)
      end
    end
  end

  def update
    @product = Product.find params[:id]
    if @product.update_attributes params[:product]
      if params[:product_photo]
        params[:product_photo].each do |f|
          Photo.create({:product_id => @product.id, :file => f})
        end
      end
      if params[:product_photo_del]
        params[:product_photo_del].each do |d|
          Photo.find(d).destroy
        end
      end
      flash.now[:notice] = "Товар успешно обновлен"
      if params[:apply]
        redirect_to edit_admin_company_product_path(@company, @product)
      else
        redirect_to admin_company_products_path(@company)
      end
    end
  end

  def destroy
    @product = Product.find params[:id]
    if @product.destroy
      redirect_to admin_company_products_path(@company), :notice => "Товар успешно удален"
    end
  end

end