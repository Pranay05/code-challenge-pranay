class CompaniesController < ApplicationController
  before_action :set_company, except: [:index, :create, :new]

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def show
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to companies_path, notice: "Saved"
    else
      flash[:alert] = @company.errors.full_messages.join('')
      render :new
    end
  rescue => e
    # exceptions because exceptions should only be used for unexpected situations
    flash[:alert] = e.message
    render :new
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to companies_path, notice: "Changes Saved"
    else
      flash[:alert] = @company.errors.full_messages.join('')
      render :edit
    end
  rescue => e
    flash[:alert] = e.message
    render :edit
  end

  def destroy
    if @company.destroy
    redirect_to companies_path, alert: "Company Deleted"
    else
      render :show
    end
  end

  private

  def company_params
    params.require(:company).permit(
      :name,
      :legal_name,
      :description,
      :zip_code,
      :phone,
      :email,
      :owner_id,
    )
  end

  def set_company
    @company = Company.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    redirect_to companies_path, alert: e.message
  end

  
end
