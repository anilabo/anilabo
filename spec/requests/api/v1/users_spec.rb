require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  let!(:user) { create(:user) }
  let!(:valid_params) {{ uid: user.uid }}
  let!(:invalid_params) {{ uid: 'hogehoge' }}

  describe "GET /api/v1/users/:uid" do
    context "該当するユーザーが存在するとき" do

      it "ステータス200を返すこと" do
        get api_v1_user_path(valid_params)
        expect(response).to have_http_status(200)
      end
    end

    context '該当するユーザーが存在しないとき' do
      it "ステータス404を返すこと" do
        get api_v1_user_path(invalid_params)
        expect(response).to have_http_status(404)
      end
    end
  end
end
