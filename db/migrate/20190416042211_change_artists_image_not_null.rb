class ChangeArtistsImageNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :artists, :image, false
  end
end
