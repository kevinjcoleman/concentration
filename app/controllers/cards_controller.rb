class CardsController < ApplicationController
  before_action :authenticate_player!

  def show
    @card = GameCard.find(params[:id])
    @card.update_attributes!(currently_picked_by_player_id: current_player.id)
  end
end
