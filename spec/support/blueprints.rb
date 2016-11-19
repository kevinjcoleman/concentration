require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

Player.blueprint do
  email { "kevin@example.com"}
  password {"password"}
  playername {"kev"}
end

Game.blueprint do
  status_cd {0}
end

GamePlayer.blueprint do
  player
  game
  role {1}
end
