require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let!(:user) { create(:user) }

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

  # describe "コールバックに関するテスト" do

  # end
end
