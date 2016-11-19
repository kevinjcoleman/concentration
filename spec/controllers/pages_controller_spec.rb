require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  describe "GET #home" do
    before { get :home }
    it { should respond_with(:success) }
    it { should render_template(:home) }
  end
end
