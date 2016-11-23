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