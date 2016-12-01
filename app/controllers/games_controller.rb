class GamesController < ApplicationController
  before_action :authenticate_player!
  before_action :find_game, except: [:create]

  def create
    game = Game.create_with_player1(current_player)
    redirect_to game_invite_path(game)
  end

  def invite
    unless @game.pending?
      flash[:success] = "Game already started."
      redirect_to game_path(@game)
    end
  end

  def accept
    if @game.pending?
      @game.start_game(current_player)
      flash[:success] = "Game started."
      redirect_to game_path(@game)
    elsif current_player.in?(@game.players)
      flash[:success] = "Game already started."
      redirect_to game_path(@game)
    else
      flash[:danger] = "You don't have access to do that."
      redirect_to root_path
    end
  end

  def show
    flash[:info] = "That game hasn't started yet!"; redirect_to game_invite_path(@game) if @game.pending?
    unless current_player.in?(@game.players)
      flash[:danger] = "You aren't a player for that game."
      redirect_to root_path
    end
  end

  def pick
    @game.add_pick(player: current_player, pick: params[:pick])
  end

  def cards
    @cards = @game.game_cards.ordered
  end

  def find_game
    @game = Game.includes(:game_cards).find(game_id)
  end

  def game_id
    params[:id] ? params[:id] : params[:game_id]
  end
end
