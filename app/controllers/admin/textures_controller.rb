# encoding: utf-8
class Admin::TexturesController < AdminController

  before_filter :breadcrumbs

  def breadcrumbs
    @breads = [['Администрирование', '/admin']]
  end

  def index
    @breads << ['Материалы']
    @textures = Texture.order("id desc").page params[:page]
  end

  def new
    @breads << ['Материалы', '/admin/textures']
    @breads << ['Создание материала']
    @texture = Texture.new
  end

  def edit
    @texture = Texture.find(params[:id])
    @breads << ['Материалы', '/admin/textures']
    @breads << ["Редактирование материала - #{@texture.name}"]
  end

  def create
    @texture = Texture.new params[:texture]
    if @texture.save
      redirect_to admin_textures_path, :notice => "Материал успешно создан"
    end
  end

  def update
    @texture = Texture.find params[:id]
    if @texture.update_attributes params[:texture]
      redirect_to admin_textures_path, :notice => "Материал успешно обновлен"
    end
  end

  def destroy
    @texture = Texture.find params[:id]
    if @texture.destroy
      redirect_to admin_textures_path, :notice => "Материал успешно удален"
    end
  end

end