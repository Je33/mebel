# encoding: utf-8
class Admin::CompaniesController < AdminController

  def index
    @breads = [['Администрирование', '/admin'],  ['Компании', '/admin/companies']]
    @companies = Company.all
  end

end