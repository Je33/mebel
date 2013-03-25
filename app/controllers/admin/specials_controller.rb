# encoding: utf-8
class Admin::SpecialsController < AdminController

  before_filter :breadcrumbs

  def breadcrumbs
    @breads = [['Администрирование', '/admin']]
  end

  def index
    @breads << ['Акции']
    @specials = Special.order("id desc").page params[:page]
  end

  def new
    @breads << ['Акции', admin_specials_path]
    @breads << ['Новая акция']
    @special = Special.new
  end

  def edit
    @special = Special.find(params[:id])
    @breads << ['Категории', admin_specials_path]
    @breads << ["Редактирование акции - #{@special.name}"]
  end

  def create
    @special = Special.new params[:special]
    if @special.save
      redirect_to admin_specials_path, :notice => "Категория успешно создана"
    end
  end

  def update
    @special = Special.find params[:id]
    if @special.update_attributes params[:special]
      redirect_to admin_specials_path, :notice => "Категория успешно обновлена"
    end
  end

  def destroy
    @special = Special.find params[:id]
    if @special.destroy
      redirect_to admin_specials_path, :notice => "Категория успешно удалена"
    end
  end

end