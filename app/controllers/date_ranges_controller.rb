require 'net/http'
require 'uri'

class DateRangesController < ApplicationController
  def create
    date_range = DateRange.new(params[:date_range])
    company = Company.find(session[:company_id])
    parse_records(company, date_range.start_date, date_range.end_date)
    redirect_to company
  end

  def parse_records(company, start_date, end_date)
    start_year = start_date.year.to_s
    start_month = (start_date.month - 1) < 10 ? 
          "0#{(start_date.month - 1).to_s}" : (start_date.month - 1).to_s
    start_day = start_date.day.to_s
    end_year = end_date.year.to_s
    end_month = (end_date.month - 1) < 10 ? 
          "0#{(end_date.month - 1).to_s}" : (end_date.month - 1).to_s
    end_day = end_date.day.to_s
    csv_file = "http://ichart.finance.yahoo.com/table.csv?" + 
      "s=#{company.abbreviation}&a=#{start_month}&b=#{start_day}" +
      "&c=#{start_year}&d=#{end_month}&e=#{end_day}&f=#{end_year}" + 
      "&g=d&ignore=.csv"
    
    csv_string = Net::HTTP.get URI.parse(csv_file)
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
                    :company_id => company.id)
    end
  end
end
