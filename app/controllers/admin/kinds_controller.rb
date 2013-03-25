# encoding: utf-8
class Admin::KindsController < AdminController

  before_filter :breadcrumbs

  def breadcrumbs
    @texture = Texture.find params[:texture_id]
    @breads = [['Администрирование', '/admin'],
               ['Текстуры', '/admin/textures'],
               [@texture.name, edit_admin_texture_path(@texture)]]
  end

  def index
    @breads << ['Виды']
    @kinds = @texture.kinds.order("id desc").page params[:page]
  end

  def new
    @breads << ['Виды', admin_texture_kinds_path(@texture)]
    @breads << ['Новый вид']
    @kind = Kind.new
  end

  def edit
    @kind = Kind.find(params[:id])
    @breads << ['Виды', admin_texture_kinds_path(@texture)]
    @breads << ["Редактирование виды - #{@kind.name}"]
  end

  def create
    @kind = Kind.new params[:kind]
    @kind.texture_id = @texture.id
    if @kind.save
      redirect_to admin_texture_kinds_path(@texture), :notice => "Вид успешно создан"
    end
  end

  def update
    @kind = Kind.find params[:id]
    if @kind.update_attributes params[:kind]
      redirect_to admin_texture_kinds_path(@texture), :notice => "Вид успешно обновлен"
    end
  end

  def destroy
    @kind = Kind.find params[:id]
    if @kind.destroy
      redirect_to admin_texture_kinds_path, :notice => "Вид успешно удален"
    end
  end

end