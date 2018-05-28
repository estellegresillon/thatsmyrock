class CreateUserAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :user_albums do |t|
      t.string :status
      t.references :user, foreign_key: true
      t.references :album, foreign_key: true
      t.boolean :vinyl, default: :false
      t.boolean :cd, default: :false
      t.boolean :digital, default: :false

      t.timestamps
    end
  end
end
