require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  describe "home page" do
    it "returns http success" do
      get :home
      expect(response).to have_http_status(:success)
    end
  end

end
