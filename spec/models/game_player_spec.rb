require 'rails_helper'

RSpec.describe GamePlayer, type: :model do
  it { should belong_to(:player) }
  it { should belong_to(:game) }
  it { should validate_presence_of(:role) }
  it do  
    should validate_inclusion_of(:role).
     in_array([1, 2])
  end
  describe "players" do 
    let!(:player1) {Player.make!}
    let!(:game) {Game.create_with_player1(player1)}
    let!(:player2) {Player.make!}
    let!(:player3) {Player.make!}
    
    before do 
      game.start_game(player2)
    end

    it "will not create another player1" do 
      expect {game.create_player(player3)}.to raise_error  ActiveRecord::RecordInvalid
    end

    it "will not create another player2" do 
      expect {game.create_player(player3, 2)}.to raise_error ActiveRecord::RecordInvalid
    end    
  end
end
