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
  end
  
  def add_company_to_index
    @company = Company.find_by_abbreviation(params[:company])
    @index = Index.find(session[:index_id])
    @index.companies << @company
    redirect_to @index
  end

end
