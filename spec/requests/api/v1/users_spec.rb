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

  describe "PATCH /api/v1/users/:uid" do
    context "未ログイン時" do
      it "ステータス401を返すこと" do
        patch api_v1_user_path({uid: user.uid})
        expect(response).to have_http_status(401)
      end
    end

    context "ログイン時" do
      before { stub_firebase(user) }

      it "ステータス200を返すこと" do
        patch api_v1_user_path({uid: user.uid, user: { display_name: "newName!" }})
        expect(response).to have_http_status(200)
      end

      it "Userモデルのレコード数が変化しないこと" do
        expect do
          patch api_v1_user_path({uid: user.uid, user: { display_name: "newName!" }})
        end.to change { User.count}.by(0)
      end

      it "current_userのdisplay_nameが更新されること" do
        expect do
          patch api_v1_user_path({uid: user.uid, user: { display_name: "newName!" }})
        end.to change { user.display_name }.from('野生のミシシッピズワイガニ').to('newName!')
      end
    end
  end

  describe "DELETE /api/v1/users/:uid" do
    context "未ログイン時" do
      it "ステータスコード401を返すこと" do
        delete api_v1_user_path(user)
        expect(response).to have_http_status(401)
      end
    end

    context "ログイン時" do
      before { stub_firebase(user) }

      it "ステータスコード200を返すこと" do
        delete api_v1_user_path(user)
        expect(response).to have_http_status(200)
      end

      it "ユーザーのレコード数が1つ減ること" do
        expect do
          delete api_v1_user_path(user)
        end.to change { User.count }.by(-1)
      end

      it "該当ユーザーが見つからないこと" do
        expect(user.display_name).to eq('野生のミシシッピズワイガニ')
        delete api_v1_user_path(user)
        expect(User.find_by(display_name: '野生のミシシッピズワイガニ')).to eq(nil) 
      end
    end
  end
end
