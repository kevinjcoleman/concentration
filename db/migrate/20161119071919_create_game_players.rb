class CreateGamePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :game_players do |t|
      t.references :game, foreign_key: true
      t.references :player, foreign_key: true
      t.integer :role

      t.timestamps
    end
  end
end
