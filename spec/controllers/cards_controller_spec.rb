require 'rails_helper'

RSpec.describe CardsController, type: :controller do

  describe "GET #show" do
    let(:card) {GameCard.create(name: "emoji")}
    let(:player) {Player.make!}

    before do
      player_sign_in(player)
      get :show, params: {id: card.id,  :format => :json}
    end

    it { should respond_with(:success) }
  end

  def player_sign_in(player)
    allow(request.env['warden']).to receive(:authenticate!).and_return(player)
    allow(controller).to receive(:current_player).and_return(player)
  end
end
