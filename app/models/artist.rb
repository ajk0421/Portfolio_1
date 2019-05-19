class Artist < ApplicationRecord
  # before_save :set_data
  mount_uploader :image, ImageUploader

  attr_accessor :image_cache

  validates :name, presence: true

  validates :furi_gana, presence: true
  validate :katanaka_valid

  validates :image, presence: true
  validates :place, presence: true
  validates :profile, presence: true
  validate :hp_valid
  validate :twitter_valid

  belongs_to :user

  def self.gozyu_on(furi_gana)
    artists = Artist.order("furi_gana ASC")

    gozyu_on_artists = artists.select{|a| a.furi_gana =~ furi_gana}
  end

  private

  # def set_data
  #   self.hp= "未登録" if hp.blank?
  #   self.twitter = "未登録" if twitter.blank?
  #   self.youtube = "未登録" if youtube.blank?
  # end

  def katanaka_valid
    errors.add(:furi_gana, 'は全角カタカナで入力して下さい') unless furi_gana =~ /([ァ-ン]|ー)+/
  end

  def hp_valid
    return if hp.blank?
    errors.add(:hp, "のアドレスが無効な値です") unless hp =~ /\A#{URI::regexp(%w(http https))}\z/
  end

  def twitter_valid
    return if twitter.blank?

    if twitter !~ /https:\/\/twitter.com\/\w+/ || twitter.size > 35
      errors.add(:twitter, "が無効な値です")
    end
  end


end
