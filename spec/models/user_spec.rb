require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user)    { create(:user) }
  let(:users)   { create_list(:provisional_user, 10) }
  let(:animes)  { create_list(:provisional_anime, 10)}

  before do
    20.times.each do |n|
      progress = ["watched", "will_watch", "watching"].sample
      if progress == "watched"
        user.user_animes.create!(anime_id: animes.sample.id, progress: progress, opinion: "hogehoge", finished_at: "2022-11-23")
      else
        user.user_animes.create!(anime_id: animes.sample.id, progress: progress)
      end
    end
  end

  describe "アソシエーションに関するテスト" do
    context "watched_animesは" do
      it "中間テーブルのprogressがwatchedであること" do
        expect(user.watched_logs.first.progress).to eq("watched")
      end

      it "アニメの配列であること" do
        expect(user.watched_animes.first.title).to include("anime")
      end
    end

    context "watching_animesは" do
      it "中間テーブルのprogressがwatchingであること" do
        expect(user.watching_logs.first.progress).to eq("watching")
      end

      it "アニメの配列であること" do
        expect(user.watched_animes.first.title).to include("anime")
      end
    end

    context "will_watch_animesは" do
      it "中間テーブルのprogressがwill_watchであること" do
        expect(user.will_watch_logs.first.progress).to eq("will_watch")
      end

      it "アニメの配列であること" do
        expect(user.watched_animes.first.title).to include("anime")
      end
    end
  end

  # describe "バリデーションに関するテスト" do
  # end

  # describe "コールバックに関するテスト" do

  # end
end
