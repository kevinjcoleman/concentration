require 'rails_helper'

RSpec.describe Game, type: :model do
  it { should have_many(:players) }
  it { should have_many(:game_players) }
  it { should validate_presence_of(:status_cd) }
  it do  
    should validate_inclusion_of(:status_cd).
     in_array([0, 1, 2])
  end

  describe "#player1" do 
    let!(:game) {Game.make!}
    let!(:player) {Player.make!}

    it "returns player who created the game" do 
      GamePlayer.make!(game: game, player: player)
      expect(game.player1).to eq(player)
    end
  end
end
