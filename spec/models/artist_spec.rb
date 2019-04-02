require 'rails_helper'

RSpec.describe Artist, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  let(:user){create(:user)}
  let(:artist){build(:artist,user_id: user.id)}

  context "必須項目を指定してるとき" do
    it "アーティストが作成される" do
      expect(artist).to be_valid
    end
  end

  context "nameが指定されていない" do
    it "エラーになる" do
      artist.name = nil
      artist.valid?

      expect(artist.errors.messages[:name]).to include("を入力して下さい。")
    end
  end

  context "furi_ganaが指定されていない" do
    it "エラーになる" do
      artist.furi_gana = nil
      artist.valid?

      expect(artist.errors.messages[:furi_gana]).to include("を入力して下さい。", "は全角カタカナで入力して下さい")
    end
  end

  context "furi_ganaが全角カタカナ以外で指定されている" do
    it "エラーになる" do
      artist.furi_gana = [Faker::Name.name,Faker::Alphanumeric.alpha,"ｶﾀｶﾅ"].sample
      artist.valid?

      expect(artist.errors.messages[:furi_gana]).to include("は全角カタカナで入力して下さい")
    end
  end

  context "imageが指定されていない" do
    it "エラーになる" do
      artist.image = nil
      artist.valid?

      expect(artist.errors.messages[:image]).to include("を入力して下さい")
    end
  end

  context "placeが指定されていない" do
    it "エラーになる" do
      artist.place = nil
      artist.valid?

      expect(artist.errors.messages[:place]).to include("を入力して下さい。")
    end
  end

  context "profileが指定されていない" do
    it "エラーになる" do
      artist.profile = nil
      artist.valid?

      expect(artist.errors.messages[:profile]).to include("を入力して下さい。")
    end
  end

end
