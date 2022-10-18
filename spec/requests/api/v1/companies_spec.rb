require 'rails_helper'

RSpec.describe "Api::V1::Companies", type: :request do
  let(:company) { create(:company) }

  describe "GET /api/v1/companies" do
    it "ステータス200を返すこと" do
      get api_v1_companies_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /api/v1/companies" do
    it "ステータス200を返すこと" do
      get api_v1_company_path(public_uid: company.public_uid)
      expect(response).to have_http_status(200)
    end

    it "該当の会社名が含まれること" do
      get api_v1_company_path(public_uid: company.public_uid)
      json = JSON.parse(response.body)
      expect(json["name"]).to eq("ファンワークス")
    end
  end
end
