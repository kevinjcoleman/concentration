class Player < ApplicationRecord
  attr_accessor :login
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :game_players
  has_many :games, through: :game_players
  has_many :game_cards
  validates_presence_of :playername
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def other_player_for_game(game)
    Player.find((game.player_ids - [id]).first)
  end
end
