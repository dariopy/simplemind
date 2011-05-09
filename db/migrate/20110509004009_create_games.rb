class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.string :game_string
      t.boolean :won
      t.boolean :lost
      t.string :guesses
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
