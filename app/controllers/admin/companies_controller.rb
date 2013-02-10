# encoding: utf-8
class Admin::CompaniesController < AdminController

  def index
    @breads = [['Администрирование', '/admin'],  ['Компании']]
    @companies = Company.order("id desc").page params[:page]
  end

  def new
    @breads = [['Администрирование', '/admin'],  ['Создание компании']]
    @company = Company.new
  end

  def edit
    @company = Company.find(params[:id])
    @breads = [['Администрирование', '/admin'],  ["Редактирование компании - #{@company.name}"]]
  end

  def create
    @company = Company.new params[:company]
    if @company.save
      redirect_to admin_companies_path, :notice => "Компания успешно создана"
    end
  end

  def update
    @company = Company.find params[:id]
    if @company.update_attributes params[:company]
      redirect_to admin_companies_path, :notice => "Компания успешно обновлена"
    end
  end

  def destroy
    @company = Company.find params[:id]
    if @company.destroy
      redirect_to admin_companies_path, :notice => "Компания успешно удалена"
    end
  end

end