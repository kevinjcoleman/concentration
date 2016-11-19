class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.references :player1, index: true
      t.references :player2, index: true
      t.integer :status_cd

      t.timestamps
    end
  end
end
