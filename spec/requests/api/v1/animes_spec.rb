require 'rails_helper'

RSpec.describe "Api::V1::Animes", type: :request do
  let(:anime) { create(:anime) }

  describe "GET /api/v1/animes" do
    it "ステータス200を返すこと" do
      get api_v1_animes_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /api/v1/:public_url" do
    it "ステータス200を返すこと" do
      get api_v1_anime_path(public_uid: anime.public_uid)
      expect(response).to have_http_status(200)
    end

    it "該当のアニメ情報を返すこと" do
      get api_v1_anime_path(public_uid: anime.public_uid)
      expect(response.body.include?('SPY×FAMILY')).to eq(true)
    end
  end
end
