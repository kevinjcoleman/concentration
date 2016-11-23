class AddPlayer1ScorePlayer2ScoreToGame < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :player1_picks, :integer, default: 0
    add_column :games, :player2_picks, :integer, default: 0
  end
end
