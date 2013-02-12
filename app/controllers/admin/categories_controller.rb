# encoding: utf-8
class Admin::CategoriesController < AdminController

  before_filter :breadcrumbs

  def breadcrumbs
    @company = Company.find params[:company_id]
    @breads = [['Администрирование', '/admin'],  ['Компании', '/admin/companies'], [@company.name, edit_admin_company_path(@company)]]
  end

  def index
    @breads << ['Категории']
    @categories = @company.categories.order("id desc").page params[:page]
  end

  def new
    @breads << ['Категории', admin_company_categories_path(@company)]
    @breads << ['Новая категория']
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
    @breads << ['Категории', admin_company_categories_path(@company)]
    @breads << ["Редактирование категории - #{@category.name}"]
  end

  def create
    @category = Category.new params[:category]
    @category.company_id = @company.id
    if @category.save
      redirect_to admin_company_categories_path(@company), :notice => "Категория успешно создана"
    end
  end

  def update
    @category = Category.find params[:id]
    if @category.update_attributes params[:company]
      redirect_to admin_company_categories_path(@company), :notice => "Категория успешно обновлена"
    end
  end

  def destroy
    @category = Company.find params[:id]
    if @category.destroy
      redirect_to admin_companies_path, :notice => "Категория успешно удалена"
    end
  end

end