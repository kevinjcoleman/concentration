require 'rails_helper'

RSpec.describe GameCard, type: :model do
  let!(:game) {Game.make!}
  let!(:player) {Player.make!}
  
  it { should belong_to(:game) }
  it { should belong_to(:player) }

  describe "self.emoji_options" do 
    it "returns all 218 emoji names" do 
      expect(GameCard.emoji_options.size).to eq(862)
    end
  end

  describe "create" do 
    it "creates without a player" do 
      GameCard.create(name: GameCard.emoji_options.first, game: game, player_id: nil)
    end

    it "fails to create when pair already exists" do 
      2.times {GameCard.create(name: "emoji", game: game)}
      expect {GameCard.create!(name: "emoji", game: game)}.to raise_error ActiveRecord::RecordInvalid
    end
  end

  describe "create_pair" do 
    before {GameCard.create_pair(game)}
    it "creates a first matching  pair" do 
      expect(GameCard.pluck(:name).uniq.count).to eq(1)
    end

    it "creates a second matching pair" do 
      GameCard.create_pair(game)
      expect(GameCard.pluck(:name).uniq.count).to eq(2)
    end
  end

  describe ".shuffle_cards" do 
    before {10.times {GameCard.create_pair(game)}}
    it "scrambles existing cards" do 
      before_shuffle = GameCard.where(game: game)
      GameCard.shuffle_cards(game)
      expect(GameCard.where(game: game).order(:order)).to_not eq(before_shuffle)
    end
  end

  describe "create_cards_for_game(number_of_pairs, game)" do 
    before {GameCard.create_cards_for_game(12, game)}
    it "creates 12 unique pairs" do 
      expect(GameCard.pluck(:name).uniq.count).to eq(12)
    end

    it "scrambles the ordering of the cards" do 
      expect(GameCard.where(game: game).order(:created_at)).to_not eq(GameCard.where(game: game).order(:order))
    end
  end

  describe "associations" do 
    let!(:game_card) {GameCard.create(name: GameCard.emoji_options.first, game: game, player: player)}
    it ".player" do 
      expect(game_card.player).to eq(player)
    end

    it ".game" do 
      expect(game_card.game).to eq(game)
    end
  end
end
