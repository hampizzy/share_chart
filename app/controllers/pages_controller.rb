class PagesController < ApplicationController
  def home
    @title = "Shart"
  end

  def chart
    @companies = Company.all(:order => :name)
    @startCompany = Company.find_by_abbreviation(".INDEX")
    @title = "#{@startCompany.name} Shart"
  end
end
