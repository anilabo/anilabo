class Api::V1::CompaniesController < Api::ApplicationController
  before_action :set_company, only: %i[show]

  def index
    @q = Company.ransack(params[:q])
    companies = @q.result(distinct: true)
    render json: companies
  end

  def show
    render json: @company, serializer: CompanyDetailSerializer
  end

  private

    def set_company
      @company = Company.find_by(public_uid: params[:public_uid])
    end
end
