class Artist < ApplicationRecord
  before_save :set_data
  mount_uploader :image, ImageUploader

  attr_accessor :image_cache

  validates :name, presence: true
  validates :furi_gana, presence: true
  validate :katanaka_valid
  validates :image, presence: true
  validates :place, presence: true
  validates :profile, presence: true

  belongs_to :user

  private

  def set_data
    self.hp= "未登録" if hp.blank?
    self.twitter = "未登録" if twitter.blank?
    self.youtube = "未登録" if youtube.blank?
  end

  def katanaka_valid
    errors.add(:furi_gana, 'は全角カタカナで入力して下さい') unless furi_gana =~ /([ァ-ン]|ー)+/
  end
end
