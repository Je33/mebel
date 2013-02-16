# encoding: utf-8
class Admin::CategoriesController < AdminController

  before_filter :breadcrumbs

  def breadcrumbs
    @breads = [['Администрирование', '/admin']]
  end

  def index
    @breads << ['Категории']
    @categories = Category.order("id desc").page params[:page]
  end

  def new
    @breads << ['Категории', admin_categories_path]
    @breads << ['Новая категория']
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
    @breads << ['Категории', admin_categories_path]
    @breads << ["Редактирование категории - #{@category.name}"]
  end

  def create
    @category = Category.new params[:category]
    if @category.save
      redirect_to admin_categories_path, :notice => "Категория успешно создана"
    end
  end

  def update
    @category = Category.find params[:id]
    if @category.update_attributes params[:category]
      redirect_to admin_categories_path, :notice => "Категория успешно обновлена"
    end
  end

  def destroy
    @category = Category.find params[:id]
    if @category.destroy
      redirect_to admin_categories_path, :notice => "Категория успешно удалена"
    end
  end

end