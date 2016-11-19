class AddPlayernameToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :playername, :string
    add_index :players, :playername, unique: true
  end
end
