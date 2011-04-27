class CompaniesController < ApplicationController
  def new
    @title = "Add new company"
    @company = Company.new
  end

  def create
    @title = "Add new company"
    @company = Company.new(params[:company])
    @company.abbreviation = @company.abbreviation.upcase
    if @company.save
      flash[:success] = "#{params[:company][:name]} added to database"
    else
      flash[:error] = "Error adding #{params[:company][:name]} to database"
    end
    redirect_to new_company_path
  end
  
  def index
    @title = "Companies"
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
    @title = "#{@company.name} (#{@company.abbreviation})"
    @new_record = Record.new(:time => 7.hours.ago(Time.now.midnight))
    @date_range = DateRange.new
    @records = @company.records.paginate(:page => params[:page])
  end

  def edit
  end

  def destroy
  end
end
