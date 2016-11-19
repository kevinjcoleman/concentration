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

  def player1
    game_players.find_by(role: GamePlayer::PLAYER1).player
  end

  def player2
    game_players.find_by(role: GamePlayer::PLAYER2).player
  end
end
