class RecordsController < ApplicationController

  def create
    @company = Company.find(session[:company_id])
    @record = Record.new(params[:record])
    @record.company_id = @company.id
    @record.adjClose = @record.close
    if @record.save
      flash[:success] = "Record added to #{@company.name}"
    else
      flash[:error] = "Error adding record to #{@company.name}"
    end
    redirect_to @company
  end
end
