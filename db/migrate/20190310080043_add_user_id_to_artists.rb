class AddUserIdToArtists < ActiveRecord::Migration[5.2]
  def up
    execute 'DELETE FROM artists;'
    add_reference :artists, :user, null: false, index: true
  end

  def down
    remove_reference :artists, :user, index: true
  end
end
