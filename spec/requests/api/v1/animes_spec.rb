require 'rails_helper'

RSpec.describe "Api::V1::Animes", type: :request do
  let(:anime) { create(:anime) }

  describe "GET /api/v1/animes" do
    it "ステータス200を返すこと" do
      get api_v1_animes_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /api/v1/animes/:public_uid" do
    it "ステータス200を返すこと" do
      get api_v1_anime_path(public_uid: anime.public_uid)
      expect(response).to have_http_status(200)
    end

    it "該当のアニメのタイトルが含まれること" do
      get api_v1_anime_path(public_uid: anime.public_uid)
      json = JSON.parse(response.body)
      expect(json["title"]).to eq("SPY×FAMILY")
    end
  end
end
