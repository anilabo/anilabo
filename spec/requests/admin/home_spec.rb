require 'rails_helper'

RSpec.describe "Admin::Home", type: :request do
  describe "GET /" do
    it "ステータス200を返すこと" do
      get root_path
      expect(response).to have_http_status(200)
    end
  end
end
