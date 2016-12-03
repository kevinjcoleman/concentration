json.cards do
  json.array! @cards do |card|
    json.id card.id
    json.name card.showName
    json.unicode card.showUnicode(current_player)
    json.isGuessed card.isGuessed?
    json.isFlipped card.currently_picked_by?(current_player)
    json.pickedByCurrentPlayer card.picked_by?(current_player)
    json.coveredImageUrl asset_path('new_jedi_order.png')
  end
end

json.game do
  json.isTurn @game.isTurn?(current_player)
  json.picks @game.game_cards.currently_picked_by(current_player)
  json.currentPlayerPicks current_player.picks_for(@game)
  json.otherPlayerPicks current_player.other_player_for_game(@game).picks_for(@game)
  json.currentPlayerScore @game.score_for(current_player)
  json.otherPlayerScore (@game.score_for(current_player.other_player_for_game(@game)))
  json.isCompleted @game.completed?
  json.isWinner @game.is_winner?(current_player)
  json.opponentName current_player.other_player_for_game(@game).playername.titlecase
  json.currentPlayerId current_player.id
end
