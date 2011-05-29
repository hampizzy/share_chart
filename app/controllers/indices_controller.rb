class IndicesController < ApplicationController
  def new
  end

  def create
    @index = Index.new(params[:index])
    if @index.save
      flash[:success] = "Successful added #{@index.name}, #{@index.abbreviation}"
    else
      flash[:error] = "Error adding #{@index.name}, #{@index.abbreviation}"
    end
    redirect_to indices_path
  end

  def index
    @title = "Indices"
    @new_index = Index.new
    @indices = Index.all
  end

  def show
    @index = Index.find(params[:id])
    @title = @index.name
    @companies = Company.all
    session[:index_id] = @index.id
  end

  def edit
  end

  def destroy
    Index.find(params[:id]).destroy
    flash[:success] = "Index removed"
    redirect_to indices_path
  end
  
  def get_index_record_data
    @index = Index.find_by_abbreviation(params[:q])
    @records = @index.index_records.all
    render :layout => false
  end
  
  def add_company_to_index
    @company = Company.find_by_abbreviation(params[:company])
    @index = Index.find(session[:index_id])
    if @index.companies.include?(@company)
      flash[:error] = "#{@company.name} already in #{@index.name}"
    else
      @index.companies << @company
      flash[:success] = "#{@company.name} added to #{@index.name}"
    end
    make_index
    redirect_to @index
  end
  
  def remove_company_from_index
    @index = Index.find(session[:index_id])
    @company = Company.find_by_abbreviation(params[:company])
    @index.companies.delete(@company)
    make_index
    redirect_to @index
  end
  
  def make_index
    @companies = @index.companies
    if @companies.empty?
      @index.index_records.each do |record|
        record.destroy
      end
    else
      size = @companies.size
      num = 0
      @companies[0].records.each do |record|
        open = 0
        high = 0
        low = 0
        close = 0
        adjClose = 0
        volume = 0
        @companies.each do |company|
          open += company.records[num].open
          high += company.records[num].high
          low += company.records[num].low
          close += company.records[num].close
          adjClose += company.records[num].adjClose
          volume += company.records[num].volume
        end
        IndexRecord.create(:time => record.time.round(2),
                           :open => (open/size).round(2),
                           :high => (high/size).round(2),
                           :low => (low/size).round(2),
                           :close => (close/size).round(2),
                           :adjClose => (adjClose/size).round(2),
                           :volume => (volume/size),
                           :index_id => @index.id)
        num += 1
      end
    end
  end

end
