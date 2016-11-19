def player_sign_in
  player = Player.make
  allow(request.env['warden']).to receive(:authenticate!).and_return(player)
  allow(controller).to receive(:current_player).and_return(player)
end