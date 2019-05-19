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

  context "hpが正しいURLで入力されている" do
    it "アーティストが作成される" do
      artist.hp = Faker::Internet.url

      expect(artist).to be_valid
    end
  end

  context "hpの値が正しく正しく入力されていない" do
    it "エラーになる" do
      artist.hp = Faker::String.random
      artist.valid?

      expect(artist.errors.messages[:hp]).to include("のアドレスが無効な値です")
    end
  end

  context "twitterの値が正しく入力されている" do
    it "アーティストが作成される" do
      artist.twitter = "https://twitter.com/_#{Faker::Internet.password(1,14)}"

      expect(artist).to be_valid
    end
  end

  context "twitterの値が正しく入力されていない" do
    context "文字数が長すぎる" do
      it "エラーする" do
        artist.twitter = "https://twitter.com/_#{Faker::Internet.password(15,30)}"
        artist.valid?

        expect(artist.errors.messages[:twitter]).to include("が無効な値です")
      end
    end

    context "ユーザー名に不正な値が入力さえれている" do
      it "エラーする" do
        artist.twitter = "https://twitter.com/-.()+-=[]{}/"
        artist.valid?

        expect(artist.errors.messages[:twitter]).to include("が無効な値です")
      end
    end

    context "TWitterのアドレスになっていない" do
      it "エラーする" do
        artist.twitter = Faker::Internet.password(15)
        artist.valid?

        expect(artist.errors.messages[:twitter]).to include("が無効な値です")

      end
    end
  end

end
