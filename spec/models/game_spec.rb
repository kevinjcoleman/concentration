require 'rails_helper'

RSpec.describe Game, type: :model do
  it { should have_many(:players) }
  it { should have_many(:game_players) }
  it { should validate_presence_of(:status_cd) }
  it do  
    should validate_inclusion_of(:status_cd).
     in_array([0, 1, 2])
  end
  context "player tests" do
    let!(:game) {Game.make!}
    let!(:player1) {Player.make!}

    context "player1" do 
      before {game.create_player(player1)}
      describe "#create_player" do
        it "creates a player1 for the game" do 
          expect(game.players).to eq [player1]
        end
      end

      describe "#player1" do 
        it "returns player who created the game" do 
          expect(game.player1).to eq(player1)
        end
      end
    end

    context "player2" do 
      let!(:player2) {Player.make!}
      before {game.create_player(player2, 2)}
      describe "#create_player" do
        it "creates a player2 for the game" do 
          expect(game.players).to eq [player2]
        end
      end

      describe "#player2" do 
        it "returns player2" do 
          expect(game.player2).to eq(player2)
        end
      end
    end  

    context "both players" do 
      let!(:player2) {Player.make!}
      before do 
        game.create_player(player1)
        game.create_player(player2, 2)
      end
      describe "#create_player" do
        it "creates a both players for the game" do 
          expect(game.players).to eq [player1, player2]
        end
      end

      describe "player1 & player2" do 
        it "doesn't return the same player" do 
          expect(game.player2).to_not eq(game.player1)
        end
      end
    end     
  end

  describe ".create_with_player1" do 
    let!(:player1) {Player.make!}
    let!(:game) {Game.create_with_player1(player1)}
    it "successfully creates a pending new game" do 
      expect(game.is_a?(Game)).to be_truthy
      expect(game.pending?).to be_truthy
    end

    it "successfully creates a player1" do 
      expect(game.player1).to eq(player1)
    end
  end

  describe ".start_game" do 
    let!(:player1) {Player.make!}
    let!(:player2) {Player.make!}
    let!(:game) {Game.create_with_player1(player1)}
    before {game.start_game(player2)}
    it "sets status to in progress" do 
      expect(game.in_progress?).to be_truthy
    end

    it "adds a player2" do 
      expect(game.player2).to eq player2
    end
  end

end
