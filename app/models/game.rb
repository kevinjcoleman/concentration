class Game < ApplicationRecord
  PAIRS_PER_GAME = 12
  COMPLETED = 2
  IN_PROGRESS = 1
  PENDING = 0
  as_enum :status, completed: COMPLETED,
                   in_progress: IN_PROGRESS,
                   pending: PENDING

  has_many :game_players, dependent: :destroy
  has_many :players, through: :game_players
  has_many :game_cards, dependent: :destroy
  belongs_to :turn_player, class_name: 'Player'
  validates_presence_of :status_cd
  validates_inclusion_of :status_cd, in: [PENDING,
                                          IN_PROGRESS,
                                          COMPLETED]
  scope :pending, -> {where(status_cd: PENDING)}
  scope :in_progress, -> {where(status_cd: IN_PROGRESS)}
  scope :completed, -> {where(status_cd: COMPLETED)}

  def self.create_with_player1(player1)
    game = create!(status_cd: PENDING)
    game.create_player(player1)
    game
  end

  def create_player(player, role=1)
    player_role = role.eql?(1) ? GamePlayer::PLAYER1 : GamePlayer::PLAYER2
    game_players.create!(player: player, role: player_role)
  end

  def player1
    game_players.find_by(role: GamePlayer::PLAYER1).player
  end

  def player2
    game_players.find_by(role: GamePlayer::PLAYER2).player
  end

  def start_game(player2)
    create_player(player2, 2)
    GameCard.create_cards_for_game(PAIRS_PER_GAME, self)
    update_attributes!(status_cd: Game::IN_PROGRESS, turn_player: player2)
  end

  def player_number(player)
    if player == player1
      "player1"
    elsif player == player2
      "player2"
    else
      raise ArgumentError, "#{player.playername} is not a player for this game."
    end
  end

  def add_pick(player: pick_player, pick: nil)
    if pick.present?
      game_cards.where(name: pick).find_each {|gc| gc.update_attributes(player_id: player.id)}
      if game_cards.unpicked.count == 0
        update_attributes!(add_pick_to_player_picks(player).merge({status_cd: COMPLETED}))
      else
        update_attributes!(add_pick_to_player_picks(player))
      end
    else
      update_attributes!(add_pick_to_player_picks(player).merge({turn_player: other_player(player)}))
      game_cards.clear_current_player_picks(player)
    end
  end

  def add_pick_to_player_picks(player)
    case player_number(player)
      when "player1"
        {player1_picks: (player1_picks + 1)}
      when "player2"
        {player2_picks: (player2_picks + 1)}
    end
  end

  def other_player(player)
    (players - [player]).first
  end

  def score_for(player)
    if player_cards = game_cards.where(player_id: player.id)
      player_cards.count / 2
    else
      0
    end
  end

  def is_winner?(player)
    if completed?
      if score_for(player) > score_for(other_player(player))
        "winner"
      elsif score_for(player) == score_for(other_player(player))
        "tied"
      else
        "loser"
      end
    else
      "not finished"
    end
  end

  def isTurn?(player)
    player == turn_player
  end
end
