# encoding: utf-8
class Admin::SettingsController < AdminController

  def index
    @breads = [['Администрирование', '/admin'],  ['Настройки']]
    @settings = Setting.order("id desc").page params[:page]
  end

  def new
    @breads = [['Администрирование', '/admin'],  ['Создание настройки']]
    @setting = Setting.new
  end

  def edit
    @setting = Setting.find(params[:id])
    @breads = [['Администрирование', '/admin'],  ["Редактирование настройки - #{@setting.name}"]]
  end

  def create
    @setting = Setting.new params[:setting]
    if @setting.save
      redirect_to admin_settings_path, :notice => "Настройка успешно создана"
    end
  end

  def update
    @setting = Setting.find params[:id]
    if @setting.update_attributes params[:setting]
      redirect_to admin_settings_path, :notice => "Настройка успешно обновлена"
    end
  end

  def destroy
    @setting = Setting.find params[:id]
    if @setting.destroy
      redirect_to admin_settings_path, :notice => "Настройка успешно удалена"
    end
  end

end