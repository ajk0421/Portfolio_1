class CreateArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
      t.string :name, null: false
      t.string :furi_gana, null: false
      t.string :image
      t.string :place
      t.text :profile, null: false
      t.string :hp
      t.string :twitter
      t.string :youtube

      t.timestamps
    end
  end
end
