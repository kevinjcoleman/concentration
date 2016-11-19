class GamesController < ApplicationController
  before_action :authenticate_player!
  before_action :find_game, only: [:accept, :invite]

  def create
    game = Game.create!(status_cd: 0)
    game.game_players.create!(player: current_player, role: GamePlayer::PLAYER1)
    redirect_to game_invite_path(game)
  end

  def invite
  end

  def accept
    if @game.pending?
      @game.game_players.create!(player: current_player, role: GamePlayer::PLAYER2)
      @game.update_attributes!(status_cd: Game::IN_PROGRESS)
      redirect_to game_path(@game)
    elsif current_player.in(@game.players)
      flash[:success] = "Game already started."
      redirect_to game_path(@game)
    else
      flash[:danger] = "You don't have access to do that."
      redirect_to root_path
    end
  end

  def show
    @game = Game.find(params[:id])
  end

  def find_game 
    @game = Game.find(params[:game_id])
  end
end
