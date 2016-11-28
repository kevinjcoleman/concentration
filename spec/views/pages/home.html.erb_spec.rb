require 'rails_helper'

RSpec.describe "pages/home.html.erb", type: :view do
  context "not signed in" do
    it "it loads the homepage" do
      render
      expect(rendered).to match(/The Concentration Game/)
    end
  end
end
