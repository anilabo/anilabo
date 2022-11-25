require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let!(:user) { create(:user) }
  let!(:provisional_user) { create(:provisional_user) } 

  before do
    5.times.each do |n|
      User.create!(display_name: "user#{n}", uid: "user#{n}", email: "user#{n}@example.com", photo_url: "https://user#{n}@example.jpg")
    end
  end

  # describe "アソシエーションに関するテスト" do

  # end

  describe "バリデーションに関するテスト" do
    it "followed_idとfollower_idは同じにならないこと" do
      expect do
        Relationship.create!(followed_id: User.first.id, follower_id: User.first.id)
      end.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'followd_idとfollower_idの組み合わせはユニークであること' do
      expect do
        Relationship.create!(followed_id: User.first.id, follower_id: User.second.id)
      end.to change { Relationship.count }.by(1)
      expect do
        Relationship.create!(followed_id: User.first.id, follower_id: User.second.id)
      end.to raise_error(ActiveRecord::RecordInvalid)
      expect do
        Relationship.create!(followed_id: User.second.id, follower_id: User.first.id)
      end.to change { Relationship.count }.by(1)
      expect do
        Relationship.create!(followed_id: User.second.id, follower_id: User.first.id)
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "コールバックに関するテスト" do
    describe '通知機能' do
      context 'create時' do
        it "Notificationのレコード数が1つ増えること" do
          expect do
            user.follow(provisional_user)
          end.to change { Notification.count }.by(1)
        end

        it 'Notificationのoperateve_user_idがfollower_idと一致すること' do
          user.follow(provisional_user)
          expect(Notification.last.operative_user_id).to eq(Relationship.last.follower_id)
        end

        it 'Notificationのpassive_user_idがfollowed_idと一致すること' do
          user.follow(provisional_user)
          expect(Notification.last.passive_user_id).to eq(Relationship.last.followed_id)
        end

        it 'ユーザーの数は変わらないこと' do
          expect do
            user.follow(provisional_user)
          end.to change { User.all.count }.by(0)
        end
      end

      context 'destroy時' do
        before do
          provisional_user.follow(user)
          user.follow(provisional_user)
        end

        it 'Notificationのレコード数が1つ減ること' do
          expect do
            user.unfollow(provisional_user)
          end.to change { Notification.count }.by(-1)
        end

        it 'Notificationのoperative_user_idがfollower_id、passive_user_idがfollowed_idのレコードが見つからないこと' do
          relationship = Relationship.last
          notification = Notification.last
          expect(notification.operative_user_id).to eq(relationship.followed_id)
          expect(notification.passive_user_id).to eq(relationship.follower_id)
          user.unfollow(provisional_user)
          relationship = Relationship.last
          notification = Notification.last
          expect(notification.operative_user_id).not_to eq(relationship.followed_id)
          expect(notification.passive_user_id).not_to eq(relationship.follower_id)
        end

        it 'ユーザーの数は変わらないこと' do
          expect do
            user.follow(provisional_user)
          end.to change { User.all.count }.by(0)
        end
      end
    end
  end
end
