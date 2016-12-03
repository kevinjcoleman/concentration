class GameCard < ApplicationRecord
  BAD_EMOJIS = %w(suspect bowtie feelsgood finnadie fu goberserk godmode hurtrealbad metal neckbeard octocat rage1 rage2 rage3 rage4 shipit trollface)
  belongs_to :game
  belongs_to :player
  belongs_to :currently_picked_player, class_name: 'Player'
  before_validation :only_two_per_game, :on => :create

  scope :ordered, -> {order(:order)}
  scope :picked, -> {where.not(player_id: nil)}
  scope :currently_picked_by, -> (player) {where(currently_picked_by_player_id: player.id)}
  scope :current_picked, ->{where.not(currently_picked_by_player_id: nil)}
  scope :unpicked, -> {where(player_id: nil)}

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

  def self.clear_current_player_picks(player)
    current_picked.where(currently_picked_by_player_id: player).update_all(currently_picked_by_player_id: nil)
  end

  def only_two_per_game
    if GameCard.where(game: game, name: name).count >= 2
      errors.add(:name, "can't have more than a pair with the same name")
    end
  end

  def unicode
    Emoji.find_by_alias(name).raw
  end

  def picked_by?(current_player)
    player == current_player
  end

  def currently_picked_by?(current_player)
    currently_picked_by_player_id == current_player.id
  end

  def isGuessed?
    player.present?
  end

  def showName
    isGuessed? ? name : nil
  end

  def showUnicode(current_player)
    shouldShow = isGuessed? || currently_picked_by?(current_player)
    shouldShow ? unicode : nil
  end
end
