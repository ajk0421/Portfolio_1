class ChangeArtistsPlaceNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :artists, :place, false
  end
end
