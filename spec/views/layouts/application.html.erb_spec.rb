require 'rails_helper'

RSpec.describe "layouts/application.html.erb", type: :view do

  it 'has a base title for the home page' do
    render template: "pages/home.html.erb", layout: "layouts/application"
    expect(rendered).to have_title "Vegan for a Week"
  end
end