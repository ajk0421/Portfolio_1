class Artist < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :name, presence: true
  validates :furi_gana, presence: true

end
