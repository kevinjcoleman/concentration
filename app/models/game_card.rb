class GameCard < ApplicationRecord
  belongs_to :game
  belongs_to :player
  validate :only_two_per_game

  def self.emoji_options
    Emoji::Index.new.instance_variable_get(:@emoji_by_name).map {|k, v| k }
  end

  def self.create_cards_for_game(number_of_pairs, game)
    number_of_pairs.times {create_pair(game)}
  end

  def self.create_pair(game)
    emoji_name = (emoji_options - GameCard.where(game: game).pluck(:name).uniq).sample
    2.times {create!(name: emoji_name, game: game)}
  end

  def only_two_per_game
    if GameCard.where(game: game, name: name).count >= 2
      errors.add(:name, "can't have more than a pair with the same name")
    end
  end
end
