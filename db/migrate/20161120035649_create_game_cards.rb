class CreateGameCards < ActiveRecord::Migration[5.0]
  def change
    create_table :game_cards do |t|
      t.string :name
      t.integer :player_id
      t.references :game, foreign_key: true

      t.timestamps
    end
  end
end
