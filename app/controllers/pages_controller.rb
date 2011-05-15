class PagesController < ApplicationController
  def home
    @title = "Shart"
  end

  def chart
    @companies = Company.all(:order => :name)
    @startCompany = Company.first
    @title = "#{@startCompany.name} Shart"
  end
end
