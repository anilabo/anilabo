require 'rails_helper'

RSpec.describe "Api::v1::Timelines", type: :request do
  let!(:user) { create(:user)}

  describe "GET /api/v1/timelines" do
    context "ログイン時" do
      before do
        stub_firebase(user)
      end

      it "ステータス200を返すこと" do
        get api_v1_timelines_path
        expect(response).to have_http_status(200)
      end
    end

    context "未ログイン時" do
      it "ステータス401を返すこと" do
        get api_v1_timelines_path
        expect(response).to have_http_status(401)
      end
    end
  end
end
