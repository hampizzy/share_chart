class PagesController < ApplicationController
  def home
    @title = "Shart"
  end

  def chart
    @companies = Company.all(:order => :name)
    @indices = Index.all(:order => :name)
    @title = "Chart"
  end
end
