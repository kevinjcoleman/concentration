class AddOrderToGameCards < ActiveRecord::Migration[5.0]
  def change
    add_column :game_cards, :order, :integer
    add_index :game_cards, :player_id
  end
end
