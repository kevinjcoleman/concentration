require 'rails_helper'

RSpec.describe GameCard, type: :model do
  let!(:game) {Game.make!}
  let!(:player) {Player.make!}

  it { should belong_to(:game) }
  it { should belong_to(:player) }

  describe "self.emoji_options" do
    it "returns all 845 emoji names" do
      expect(GameCard.emoji_options.size).to eq(845)
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
      before_shuffle = GameCard.where(game: game).order(:created_at)
      GameCard.shuffle_cards(game)
      expect(GameCard.where(game: game).ordered).to_not eq(before_shuffle)
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
    it "#player" do
      expect(game_card.player).to eq(player)
    end

    it "#game" do
      expect(game_card.game).to eq(game)
    end
  end

  describe "#picked_by?" do
    let!(:game_card) {GameCard.create(name: GameCard.emoji_options.first, game: game, player: player)}
    let!(:wrong_player) {Player.make}
    context "the right player" do
      it "returns true" do
        expect(game_card.picked_by?(player)).to eq(true)
      end
    end

    context "the wrong player" do
      it "returns false" do
        expect(game_card.picked_by?(wrong_player)).to eq(false)
      end
    end
  end

  describe "scopes" do
    before do
      2.times {GameCard.create(name: GameCard.emoji_options.shuffle,
                               game: game,
                               player: player)}
      3.times {GameCard.create(name: GameCard.emoji_options.shuffle,
                               game: game)}
    end
    let!(:wrong_player) {Player.make}
    context "picked" do
      it "returns 2" do
        expect(GameCard.picked.count).to eq(2)
      end
    end

    context "unpicked" do
      it "returns 3" do
        expect(GameCard.unpicked.count).to eq(3)
      end
    end
  end

  describe "showName" do
    let!(:player) {Player.make!}
    let(:guessed) {GameCard.make(player_id: player.id)}
    let(:not_guessed) {GameCard.make}

    context "guessed" do
      it "is name" do
        expect(guessed.showName).to eq(guessed.name)
      end
    end

    context "not guessed" do
      it "is nil" do
        expect(not_guessed.showName).to be nil
      end
    end
  end

  describe "showUnicode" do
    let!(:player) {Player.make!}
    let!(:other_player) {Player.make!}
    let(:guessed) {GameCard.make(player_id: player.id)}
    let(:currently_picked) {GameCard.make(currently_picked_by_player_id: other_player.id)}
    let(:not_guessed) {GameCard.make}

    context "guessed" do
      it "is unicode" do
        expect(guessed.showUnicode(player)).to eq(guessed.unicode)
      end
    end

    context "picked" do
      it "is unicode" do
        expect(guessed.showUnicode(other_player)).to eq(guessed.unicode)
      end
    end

    context "neither" do
      it "is nil" do
        expect(not_guessed.showUnicode(player)).to be nil
      end
    end
  end
end
