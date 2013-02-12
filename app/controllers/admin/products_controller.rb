# encoding: utf-8
class Admin::ProductsController < AdminController

  before_filter :breadcrumbs

  def breadcrumbs
    @company = Company.find params[:company_id]
    @category = Category.find params[:category_id]
    @breads = [['Администрирование', '/admin'],
               ['Компании', '/admin/companies'],
               [@company.name, edit_admin_company_path(@company)],
               ['Категории', admin_company_categories_path(@company)],
               [@category.name, edit_admin_company_category_path(@company, @category)]]
  end

  def index
    @breads << ['Товары']
    @products = @category.products.order("id desc").page params[:page]
  end

  def new
    @breads << ['Товары', admin_company_category_products_path(@company, @category)]
    @breads << ['Новый товар']
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
    @breads << ['Товары', admin_company_category_products_path(@company, @category)]
    @breads << ["Редактирование товара - #{@category.name}"]
  end

  def create
    @product = Product.new params[:product]
    @product.company_id = @company.id
    @product.category_id = @category.id
    if @product.save
      if params[:product_photo]
        params[:product_photo].each do |f|
          file = Photo.create({:product_id => @product.id, :file => f})
        end
      end
      flash.now[:notice] = "Товар успешно создан"
      if params[:apply]
        redirect_to edit_admin_company_category_product_path(@company, @category, @product)
      else
        redirect_to admin_company_category_products_path(@company, @category)
      end
    end
  end

  def update
    @product = Product.find params[:id]
    if @product.update_attributes params[:product]
      if params[:product_photo]
        params[:product_photo].each do |f|
          file = Photo.create({:product_id => @product.id, :file => f})
        end
      end
      if params[:product_photo_del]
        params[:product_photo_del].each do |d|
          Photo.find(d).destroy
        end
      end
      flash.now[:notice] = "Товар успешно обновлен"
      if params[:apply]
        redirect_to edit_admin_company_category_product_path(@company, @category, @product)
      else
        redirect_to admin_company_category_products_path(@company, @category)
      end
    end
  end

  def destroy
    @product = Product.find params[:id]
    if @product.destroy
      redirect_to admin_company_category_products_path(@company, @category), :notice => "Товар успешно удален"
    end
  end

end