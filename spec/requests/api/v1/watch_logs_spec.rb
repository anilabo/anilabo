require 'rails_helper'

RSpec.describe "Api::V1::WatchLogs", type: :request do
  let!(:user) { create(:user) }
  let!(:anime) { create(:anime) }
  describe "POST /api/v1/animes/:anime_public_uid/watch_logs" do
    let(:valid_params) {{ anime_public_uid: anime.public_uid, watch_log: { progress: "watched", opinion: "面白い", finished_at: "2022-11-13" }}}
    let(:invalid_params) {{ anime_public_uid: anime.public_uid, watch_log: { progress: nil }}}

    context "logged_in_userと該当するアニメの情報がないとき" do
      it 'user_animeレコードが1つ増えること' do
        expect do
          post api_v1_anime_watch_logs_path(valid_params)
        end.to change { UserAnime.count }.by(1)
      end

      it 'レスポンスで該当するアニメの情報を返すこと' do
        post api_v1_anime_watch_logs_path(valid_params)
        json = JSON.parse(response.body)
        expect(json["title"]).to eq("SPY×FAMILY")
      end

      it 'レスポンスしたアニメの情報にlogged_in_userの名前が含まれること' do
        post api_v1_anime_watch_logs_path(valid_params)
        json = JSON.parse(response.body)
        expect(json["watched_users"][0]["display_name"]).to eq("野生のミシシッピズワイガニ")
      end
    end

    context 'logged_in_userと該当するアニメのuser_animeレコードが既にあるとき' do
      before do
        user.user_animes.create!(anime_id: anime.id, progress: "watching")
      end

      it 'user_animeレコードの数が変化しないこと' do
        expect do
          post api_v1_anime_watch_logs_path(valid_params)
        end.to change { UserAnime.count }.by(0)
      end

      it 'レスポンスで該当するアニメの情報を返すこと' do
        post api_v1_anime_watch_logs_path(valid_params)
        json = JSON.parse(response.body)
        expect(json["title"]).to eq("SPY×FAMILY")
      end

      it 'レスポンスしたアニメの情報にlogged_in_userの名前が含まれること' do
        post api_v1_anime_watch_logs_path(valid_params)
        json = JSON.parse(response.body)
        expect(json["watching_users"]).to eq([])
        expect(json["watched_users"][0]["display_name"]).to eq("野生のミシシッピズワイガニ")
      end

      it 'progressが更新されること' do
        expect do
          post api_v1_anime_watch_logs_path(valid_params) 
        end.to change { user.user_animes.first.progress }.from('watching').to('watched')
      end
    end

    context "失敗時" do
      it 'user_anmeレコードの数が変化しないこと' do
        expect do
          post api_v1_anime_watch_logs_path(invalid_params)
        end.to change { UserAnime.count }.by(0)
      end

      it 'エラーメッセージを返すこと' do
        post api_v1_anime_watch_logs_path(invalid_params)
        json = JSON.parse(response.body)
        expect(json[0]).to eq("Progressを入力してください")
      end
    end
  end

  describe "DELETE /api/v1/animes/:anime_public_uid/watch_logs" do
    context "成功時" do
      before do
        UserAnime.create!(user_id: user.id, anime_id: anime.id, progress: 'watching')
      end

      it "user_animesのレコードが一つ減ること" do
        expect do
          delete api_v1_anime_watch_logs_path({ anime_public_uid: anime.public_uid })
        end.to change { UserAnime.count }.by(-1)
      end

      it 'userのレコード数が変化しないこと' do
        expect do
          delete api_v1_anime_watch_logs_path({ anime_public_uid: anime.public_uid })
        end.to change { User.count }.by(0)
      end

      it 'animeのレコード数が変化しないこと' do
        expect do
          delete api_v1_anime_watch_logs_path({ anime_public_uid: anime.public_uid })
        end.to change { Anime.count }.by(0)
      end
    end

    # context '失敗時' do

    # end
  end
end
