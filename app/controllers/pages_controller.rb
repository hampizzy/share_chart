class PagesController < ApplicationController
  def home
    @title = "Home"
  end

  def chart
    @title = "Chart"
  end
  
  def post_chart
    render :layout => false
  end

end
