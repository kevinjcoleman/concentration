json.cards do
  json.array! @cards do |card|
    json.id card.id
    json.name card.name
    json.unicode card.unicode
    json.isGuessed card.player_id
    json.isFlipped false
  end
end

json.opponent do
  json.id current_player.other_player_for_game(@game).id
  json.name current_player.other_player_for_game(@game).playername.titlecase
end

json.current_player do
  json.id current_player.id
  json.name current_player.playername.titlecase
end

json.game do
  json.isTurn (current_player == @game.turn_player)
  json.currentPlayerPicks current_player.picks_for(@game)
  json.otherPlayerPicks current_player.other_player_for_game(@game).picks_for(@game)
  json.currentPlayerScore @game.score_for(current_player)
  json.otherPlayerScore (@game.score_for(current_player.other_player_for_game(@game)))
end