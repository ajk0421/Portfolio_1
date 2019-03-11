class Artist < ApplicationRecord
  before_validation :set_data
  mount_uploader :image, ImageUploader

  validates :name, presence: true
  validates :furi_gana, presence: true
  validates :place, presence: true
  validates :profile, presence: true

  belongs_to :user

  private

  def set_data
    self.hp= "未登録" if hp.blank?
    self.twitter = "未登録" if twitter.blank?
    self.youtube = "未登録" if youtube.blank?
  end
end
