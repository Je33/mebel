# encoding: utf-8
class Admin::TexturesController < AdminController

  def index
    @breads = [['Администрирование', '/admin'],  ['Материалы']]
    @textures = Texture.order("id desc").page params[:page]
  end

  def new
    @breads = [['Администрирование', '/admin'],  ['Создание материала']]
    @texture = Texture.new
  end

  def edit
    @texture = Texture.find(params[:id])
    @breads = [['Администрирование', '/admin'],  ["Редактирование материала - #{@texture.name}"]]
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