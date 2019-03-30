require 'rails_helper'

RSpec.describe Artist, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"


  context "name を指定してるとき" do
    it "アーティストが作成される" do
      # sign_in←上手くいかないのでコメントアウト
      artist = Artist.new(name: "テスト", furi_gana: "テスト", image: Rails.root.join("public/test.jpg").open, place: "札幌", profile: "テスト", user_id: 1)
      expect(artist.valid?).to eq true

    end
  end
end
