require 'rails_helper'

RSpec.describe "UserLogins", type: :request do

  describe "login tests" do
    it "works! (now write some real specs)" do
      get login_path
      expect(response).to have_http_status(200)
    end

    it "correctly displays error message upon invalid login" do
    	get login_path
    	expect(response).to render_template('sessions/new')
      post login_path, params: { session: { email: "", password: "" } }
      expect(response).to render_template('sessions/new')
      expect(flash).not_to be_empty
      get root_path
      expect(flash).to be_empty
    end
  end
end

