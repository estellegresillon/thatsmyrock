class CreateTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :tracks do |t|
      t.string :name
      t.references :album, foreign_key: true
      t.integer :duration

      t.timestamps
    end
  end
end
