require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

Player.blueprint do
  email { "#{sn}@example.com"}
  password {"password"}
  playername {"#{sn}"}
end

Game.blueprint do
  status_cd {0}
end

GamePlayer.blueprint do
  player
  game
  role {1}
end
