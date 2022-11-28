require 'rails_helper'

RSpec.describe Notification, type: :model do
  let!(:user) { create(:user) }
  let!(:anime) { create(:anime)}
  let!(:provisional_user) { create(:provisional_user) }

  describe "バリデーションに関するテスト" do
    context "actionがfollowのとき" do
      # 「higakijinさんが野生のミシシッピズワイガニをフォローしました」
      it "passive_user_id, operative_user_idが必須であること" do
        expect do
          Notification.create!({ operative_user_id: user.id, action: "follow", passive_user_id: provisional_user.id })
        end.to change { Notification.count }.by(1)
        expect do
          Notification.create!({ action: "follow", passive_user_id: provisional_user.id })
        end.to raise_error(ActiveRecord::RecordInvalid)
        expect do
          Notification.create!({ operative_user_id: user.id, action: "follow" })
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "actionがwill_watch, watching, opinionのとき" do
      # 「higakijinさんが『冴えないカニの育て方』を後で見るに追加しました」
      before do
        @watch_log = user.user_animes.create!(anime_id: anime.id, progress: "will_watch")
      end
      it "operative_user_id, anime_id, watch_log_idが必須であること" do
        expect do
          Notification.create!({ operative_user_id: user.id, action: "will_watch", watch_log_id: @watch_log.id, anime_id: anime.id })
        end.to change { Notification.count }.by(1)
        expect do
          Notification.create!({ operative_user_id: user.id, action: "will_watch", watch_log_id: @watch_log.id })
        end.to raise_error(ActiveRecord::RecordInvalid)
        expect do
          Notification.create!({ operative_user_id: user.id, action: "will_watch", anime_id: @watch_log.id})
        end.to raise_error(ActiveRecord::RecordInvalid)
        expect do
          Notification.create!({ operative_user_id: user.id, action: "opinion", watch_log_id: @watch_log.id, anime_id: anime.id })
        end.to change { Notification.count }.by(1)
      end
    end
  end
end
