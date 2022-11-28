require 'rails_helper'

RSpec.describe "rails_admin", type: :request do
  describe 'GET /admin' do
    context "未ログイン時" do
      it "ルートページにリダイレクトされること" do
        expect do
          get rails_admin_path
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "ログインユーザーがadmin=trueのとき" do
      # let(:user) { create(:user) }
      # get rails_admin_path
    end
  end
end
