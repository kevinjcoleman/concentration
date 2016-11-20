class GamePlayer < ApplicationRecord
  PLAYER1 = 1
  PLAYER2 = 2
  belongs_to :game
  belongs_to :player
  validates_presence_of :role
  validates_inclusion_of :role, in: [PLAYER1, PLAYER2]
  validates_uniqueness_of :game, scope: :role
end
