require 'rails_helper'

RSpec.describe Game, type: :model do
  it { should have_many(:players) }
  it { should have_many(:game_players) }
  it { should have_many(:game_cards) }
  it { should belong_to(:turn_player) }
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

    it "creates game cards" do 
      expect(game.game_cards.count).to eq 24
    end

    it "adds player2 as the current turn player" do 
      expect(game.turn_player).to eq player2
    end
  end

  describe ".player_number" do
    let!(:player1) {Player.make!}
    let!(:player2) {Player.make!}
    let(:player3) {Player.make!}
    let!(:game) {Game.create_with_player1(player1)}
    before {game.start_game(player2)}

    it "returns player1" do
      expect(game.player_number(player1)).to eq "player1"
    end

    it "returns player2" do
      expect(game.player_number(player2)).to eq "player2"
    end

    it "raises error" do
      expect {game.player_number(player3)}.to raise_error ArgumentError, "#{player3.playername} is not a player for this game." 
    end
  end

  describe ".add_pick" do
    let!(:player1) {Player.make!}
    let!(:player2) {Player.make!}
    let!(:game) {Game.create_with_player1(player1)}
    before {game.start_game(player2)}

    context "without params" do 
      context "player1" do 
        before do 
          game.add_pick(player: player2)
          game.add_pick(player: player1)
        end
        
        it "adds a pick" do
          expect(game.player1_picks).to eq 1
        end

        it "switches turn" do
          expect(game.turn_player).to eq player2
        end
      end

      context "player2" do 
        before {game.add_pick(player: player2)}
        
        it "adds a pick" do
          expect(game.player2_picks).to eq 1
        end

        it "switches turn" do
          expect(game.turn_player).to eq player1
        end
      end
    end

    context "with params" do 
      let!(:pick1) {game.game_cards.first.name}
      let!(:pick2) {game.game_cards.first.name}
      context "player1" do 
        before do 
          game.add_pick(player: player2)
          game.add_pick(player: player1, pick: pick2)
        end
        
        it "adds a pick" do
          expect(game.player1_picks).to eq 1
        end

        it "adds score" do
          expect(game.score_for(player1)).to eq 1
        end

        it "keeps the turn" do
          expect(game.turn_player).to eq player1
        end
      end

      context "player2" do 
        before do 
          game.add_pick(player: player1)
          game.add_pick(player: player2, pick: pick1)
        end
        
        it "adds a pick" do
          expect(game.player2_picks).to eq 1
        end

        it "adds score" do
          expect(game.score_for(player2)).to eq 1
        end

        it "keeps the turn" do
          expect(game.turn_player).to eq player2
        end
      end
    end
  end

  describe ".other_player" do
    let!(:player1) {Player.make!}
    let!(:player2) {Player.make!}
    let!(:game) {Game.create_with_player1(player1)}
    before {game.start_game(player2)}

    context "player1" do 
      it "returns player2" do
        expect(game.other_player(player1)).to eq player2
      end
    end

    context "player2" do 
      it "returns player1" do
        expect(game.other_player(player2)).to eq player1
      end
    end
  end
end
