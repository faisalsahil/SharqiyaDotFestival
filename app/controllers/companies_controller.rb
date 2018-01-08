class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  
  def index
    @companies = Company.all
  end
  
  def show
    @company_addresses = @company.company_addresses
  end
  
  def new
    @company = Company.new
    1.times { @company.company_addresses.build }
  end

  def create
    @company = Company.new(company_params)
  
    if @company.save
      redirect_to @company, notice: 'Company was successfully created.'
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @company.update(company_params)
      redirect_to @company, notice: 'Company was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
    if @company.present?
      if @company.is_active?
        @company.is_active = false
      else
        @company.is_active = true
      end
      @company.save
    end
    
    redirect_to companies_url, notice: 'Company was successfully destroyed.'
  end

  private
    def set_company
      @company = Company.find(params[:id])
    end
  
    def company_params
      params.require(:company).permit(:company_name, :company_logo, :short_description, :description, :is_seen, :is_active, company_addresses_attributes: [:street, :city, :state, :zip])
    end
end
