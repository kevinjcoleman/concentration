class AddCurrentPlayerPickedIdToGameCard < ActiveRecord::Migration[5.0]
  def change
    add_column :game_cards, :currently_picked_by_player_id, :integer
    add_index :game_cards, :currently_picked_by_player_id
  end
end
