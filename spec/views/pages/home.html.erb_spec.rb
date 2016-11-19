require 'rails_helper'

RSpec.describe "pages/home.html.erb", type: :view do
  context "it loads the homepage" do 
    it "contains the homepage title" do 
      render
      expect(rendered).to match /The Concentration Game/
    end
  end
end
