json.cards do
  json.array! @cards do |card|
    json.id card.id
    json.name card.isGuessed? ? card.name : nil
    json.unicode (card.isGuessed? || card.currently_picked_by?(current_player)) ? card.unicode : nil
    json.isGuessed card.player_id || nil
    json.isFlipped card.currently_picked_by?(current_player)
    json.pickedByCurrentPlayer card.picked_by?(current_player)
    json.coveredImageUrl asset_path('new_jedi_order.png')
  end
end

json.game do
  json.isTurn (current_player == @game.turn_player)
  json.picks @game.game_cards.current_picked
  json.currentPlayerPicks current_player.picks_for(@game)
  json.otherPlayerPicks current_player.other_player_for_game(@game).picks_for(@game)
  json.currentPlayerScore @game.score_for(current_player)
  json.otherPlayerScore (@game.score_for(current_player.other_player_for_game(@game)))
  json.isCompleted @game.completed?
  json.isWinner @game.is_winner?(current_player)
  json.opponentName current_player.other_player_for_game(@game).playername.titlecase
  json.currentPlayerId current_player.id
end
