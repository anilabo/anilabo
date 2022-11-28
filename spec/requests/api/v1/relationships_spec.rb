require 'rails_helper'

RSpec.describe "Api::V1::Relationships", type: :request do
  let(:headers) {{ 'Content-Type': 'application/json', Authorization: "Bearer token" }}
  let(:user) { create(:user) }
  let(:provisional_user) { create(:provisional_user)}
  let(:valid_params) {{ user_uid: provisional_user.uid }}

  describe "POST /api/v1/relationships" do
    context "未ログイン時" do
      it "認証エラー" do
        post api_v1_relationships_path
        expect(response).to have_http_status(401)
      end
    end

    context "ログイン時" do
      before { stub_firebase(user) }

      it "ステータス200を返すこと" do
        post api_v1_relationships_path(valid_params)
        expect(response).to have_http_status(200)
      end

      it "ログインユーザーのfollowingsが1つ増えること" do
        expect do
          post api_v1_relationships_path(valid_params)
        end.to change { user.followings.count }.by(1)
      end

      it "ログインユーザーの情報をレスポンスすること" do
        post api_v1_relationships_path(valid_params)
        json = JSON.parse(response.body)
        expect(json["display_name"]).to eq("野生のミシシッピズワイガニ")
      end
    end

    context "フォローする相手が見つからないとき" do
      before { stub_firebase(user) }

      it "ステータス400を返すこと" do
        post api_v1_relationships_path
        expect(response).to have_http_status(400)
      end
    end
  end

  describe "DELETE /api/v1/relationships" do
    context "未ログイン時" do
      it "認証エラー" do
        delete api_v1_relationships_path
        expect(response).to have_http_status(401)
      end
    end

    context "ログイン時" do
      before { user.follow(provisional_user) }
      before { stub_firebase(user) }

      it "ログインユーザーのfollowingsが1つ減ること" do
        expect do
          delete api_v1_relationships_path(valid_params)
        end.to change { user.followings.count }.by(-1)
      end

      it "ログインユーザーの情報をレスポンスすること" do
        delete api_v1_relationships_path(valid_params)
        json = JSON.parse(response.body)
        expect(json['display_name']).to eq('野生のミシシッピズワイガニ')
      end

      it "ステータス400を返すこと" do
        delete api_v1_relationships_path(valid_params)
        expect(response).to have_http_status(200)
      end
    end

    context "フォローする相手が見つからないとき" do
      before { stub_firebase(user) }

      it "ステータス400を返すこと" do
        delete api_v1_relationships_path
        expect(response).to have_http_status(400)
      end
    end
  end
end
