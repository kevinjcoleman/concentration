class CardsController < ApplicationController
  def show
    @card = GameCard.find(params[:id])
  end
end
