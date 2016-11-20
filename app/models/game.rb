class Game < ApplicationRecord
  COMPLETED = 2
  IN_PROGRESS = 1
  PENDING = 0
  as_enum :status, completed: COMPLETED, 
                   in_progress: IN_PROGRESS, 
                   pending: PENDING

  has_many :game_players
  has_many :players, through: :game_players
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
    update_attributes!(status_cd: Game::IN_PROGRESS)
  end
end
