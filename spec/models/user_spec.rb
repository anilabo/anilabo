require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user)   { create(:user) }
  let(:users)   { create_list(:provisional_user, 10) }
  let(:provisional_user) { create(:provisional_user) }
  let(:anime)   { create(:provisional_anime) }
  let(:animes)  { create_list(:provisional_anime, 10)}

  
  describe "アソシエーションに関するテスト" do
    describe "サブスクライブ機能" do
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

    describe "フォロー機能" do
      before do
        Relationship.create(follower_id: user.id, followed_id: users.sample.id)
        Relationship.create(follower_id: users.sample.id, followed_id: user.id)
      end

      context "followingは" do
        it "ユーザーの配列であること" do
          expect(user.followings.first.email).to include('@example.com')
        end
      end

      context "followersは" do
        it "ユーザーの配列であること" do
          expect(user.followers.first.email).to include('@example.com')
        end
      end
    end

    describe "通知・アクティビティ機能" do
      before do
        10.times.each do |n|
          Notification.create(operative_user_id: user.id, passive_user_id: users.sample.id, action: "will_watch")
          Notification.create(operative_user_id: users.sample.id, passive_user_id: user.id, action: "watching")
        end
      end

      context "active_notificationsは" do
        it "operative_userが自分であること" do
          expect(user.active_notifications.first.operative_user_id).to eq(user.id)
        end
      end

      context "passive_notificationsは" do
        it "passive_userが自分であること" do
          expect(user.passive_notifications.first.passive_user_id).to eq(user.id)
        end
      end
    end
  end

  describe "メソッドに関するテスト" do
    describe "フォロー機能" do
      context "followしたとき" do
        it "Relationshipのレコードが1つ増えること" do
          expect do
            user.follow(users.sample)
          end.to change { Relationship.count }.by(1)
        end

        it "followingsの数が1つ増えること" do
          expect do
            user.follow(users.sample)
          end.to change { user.followings.count }.by(1)
        end

        it '相手のfollowersに自分が追加されること' do
          target_user = users.sample
          user.follow(target_user)
          expect(target_user.followers).to include(user)
        end

        it 'followersの数は変化しないこと' do
          expect do
            user.follow(users.sample)
          end.to change { user.followers.count }.by(0)
        end
      end

      context "unfollowしたとき" do
        before do
          @target_user = users.sample
          user.follow(@target_user)
        end

        it "Relathinshipのレコードが1つ減ること" do
          expect do
            user.unfollow(@target_user)
          end.to change { Relationship.count }.by(-1)
        end

        it "followingsの数が一つ減ること" do
          expect do
            user.unfollow(@target_user)
          end.to change { user.followings.count }.by(-1)
        end

        it '相手のfollowersから自分が削除されること' do
          expect(@target_user.followers).to include(user)
          user.unfollow(@target_user)
          expect(@target_user.followers).not_to include(user)
        end

        it 'followersの数は変化しないこと' do
          expect do
            user.unfollow(@target_user)
          end.to change { user.followers.count }.by(0)
        end
      end

      context "following?は" do
        it "booleanであること" do
          expect(user.following?(@target_user)).to eq(false)
          target_user = users.sample
          user.follow(target_user)
          expect(user.following?(target_user)).to eq(true)
        end
      end
    end
  end

  # describe "バリデーションに関するテスト" do
  # end

  describe 'コールバックに関するテスト' do
    before do
      user.follow(provisional_user)
      user.user_animes.create!(anime_id: anime.id, progress: "watching")
    end

    context 'destroy時' do
      it 'Userのレコードが一つ減ること' do
        expect do
          user.destroy
        end.to change { User.count }.by(-1)
      end

      it 'UserAnimeのレコードが一つ減ること' do
        expect do
          user.destroy
        end.to change { UserAnime.count }.by(-1)
      end

      it 'Relationshipのレコードが一つ減ること' do
        expect do
          user.destroy
        end.to change { Relationship.count }.by(-1)
      end

      it 'Notificationのレコードが一つ減ること' do
        notificatio_count = user.active_notifications.count + user.passive_notifications.count
        expect do
          user.destroy
        end.to change { Notification.count }.by(-notificatio_count)
      end

      it 'Animeのレコード数は変化しないこと' do
        expect do
          user.destroy
        end.to change { Anime.count }.by(0)
      end

      it 'UserAnimeのレコード数が1つ減ること' do
        expect do
          user.destroy
        end.to change { UserAnime.count }.by(-1)
      end
    end
  end
end
