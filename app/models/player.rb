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

  def picks_for(game)
    case game_players.where(game: game).first.role
      when GamePlayer::PLAYER1
        game.player1_picks
      when GamePlayer::PLAYER2
        game.player2_picks
    end
  end

  def lifetime_score
    games.each_with_object(Hash.new(0)) do |game, hsh|
      case game.is_winner?(self)
        when "winner"
          hsh[:wins] += 1
        when "loser"
          hsh[:loses] += 1
        when "tie"
          hsh[:ties] += 1
      end
    end
  end
end
