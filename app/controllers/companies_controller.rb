require 'net/http'
require 'uri'

class CompaniesController < ApplicationController
  def new
    @title = "Add new company"
    @company = Company.new
  end

  def create
    @title = "Add new company"
    @company = Company.new(params[:company])
    @company.abbreviation = @company.abbreviation.upcase
    
    start_year = "2010"
    start_month = "00"
    start_day = "1"
    end_year = Time.now.year.to_s
    end_month = (Time.now.month - 1) < 10 ? 
          "0#{(Time.now.month - 1).to_s}" : (Time.now.month - 1).to_s
    end_day = Time.now.day.to_s
    csv_file = "http://ichart.finance.yahoo.com/table.csv?" + 
      "s=#{@company.abbreviation}&a=#{start_month}&b=#{start_day}" +
      "&c=#{start_year}&d=#{end_month}&e=#{end_day}&f=#{end_year}" + 
      "&g=d&ignore=.csv"
    
    csv_string = Net::HTTP.get URI.parse(csv_file)
    
    if csv_string.first == "<"
      flash[:error] = "Error retrieving data for #{params[:company][:abbreviation].upcase}"
    else
      if @company.save
        
        lines = csv_string.split("\n")
        lines = lines.drop(1)
        lines.each do |line|
          atts = line.split(",")
          Record.create(:time => atts[0],
                        :open => atts[1],
                        :high => atts[2],
                        :low => atts[3],
                        :close => atts[4],
                        :volume => atts[5],
                        :adjClose => atts[6],
                        :company_id => @company.id)
        end
        flash[:success] = "#{params[:company][:name]} added to database"
      else
        flash[:error] = "Error adding #{params[:company][:name]} to database"
      end
    end
    redirect_to @company
  end
  
  def index
    @title = "Companies"
    @companies = Company.all(:conditions => "abbreviation != '.INDEX'")
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
    Company.find(params[:id]).destroy
    flash[:success] = "Company removed"
    redirect_to companies_path
  end
  
  def get_company_record_data
    @company = Company.find_by_abbreviation(params[:q])
    @records = @company.records.all
    render :layout => false
  end
  
end
