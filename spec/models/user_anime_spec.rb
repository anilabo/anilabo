require 'rails_helper'

RSpec.describe UserAnime, type: :model do
  let!(:user) { create(:user) }
  let!(:anime) { create(:anime) }

  describe "バリデーションに関するテスト" do
    context "progressがwatchedのとき" do
      before do
        @watch_log = user.user_animes.new(anime_id: anime.id, progress: "watched")
      end

      it 'opinionが必須になること' do
        expect(@watch_log.errors.full_messages).to include('Opinionを入力してください') unless @watch_log.valid?
      end

      it 'finished_atが必須になること' do
        expect(@watch_log.errors.full_messages).to include('Finished atを入力してください') unless @watch_log.valid?
      end
    end

    context 'progressがwatched以外のとき' do
      before do
        @watch_log = user.user_animes.new(anime_id: anime.id, progress: "watching", opinion: "まだ面白くない", finished_at: "2022-11-13", is_spoiler: true)
      end

      it 'opinion, finished_at, is_spoilerがnilで保存されること' do
        @watch_log.save!
        expect(@watch_log.opinion).to eq(nil)
        expect(@watch_log.finished_at).to eq(nil)
        expect(@watch_log.is_spoiler).to eq(false)
        @watch_log.update!(progress: "watched", opinion: '面白かった！', finished_at: '2022-11-14', is_spoiler: true)
        expect(@watch_log.opinion).to eq("面白かった！")
        expect(@watch_log.finished_at).to eq('2022-11-14 00:00:00.000000000 +0000')
        expect(@watch_log.is_spoiler).to eq(true)
        @watch_log.update!(progress: "will_watch", opinion: '面白そう', finished_at: '2022-11-15')
        expect(@watch_log.opinion).to eq(nil)
        expect(@watch_log.finished_at).to eq(nil)
        expect(@watch_log.is_spoiler).to eq(false)
      end
    end
  end
end
