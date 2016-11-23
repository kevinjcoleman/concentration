class GameCard < ApplicationRecord
  BAD_EMOJIS = %w(suspect)
  belongs_to :game
  belongs_to :player
  before_validation :only_two_per_game, :on => :create

  scope :ordered, -> {order(:order)} 

  def self.emoji_options
    Emoji.all.map {|e| e.aliases.first } - BAD_EMOJIS
  end

  def self.create_cards_for_game(number_of_pairs, game)
    number_of_pairs.times {create_pair(game)}
    shuffle_cards(game)
  end

  def self.create_pair(game)
    emoji_name = (emoji_options - GameCard.where(game: game).pluck(:name).uniq).sample
    2.times {create!(name: emoji_name, game: game)}
  end

  def  self.shuffle_cards(game)
    where(game: game).shuffle.shuffle.each_with_index do |card, index|
      card.update_attributes!(order: index)
    end
  end

  def only_two_per_game
    if GameCard.where(game: game, name: name).count >= 2
      errors.add(:name, "can't have more than a pair with the same name")
    end
  end

  def unicode
    Emoji.find_by_alias(name).raw
  end
end
