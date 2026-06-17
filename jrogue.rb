class Jrogue < Formula
  desc "Rogue: Rogue 5.4.5 with Japanese/English runtime switching, color, and macOS fixes"
  homepage "https://leopard-gecko.github.io/jrogue/"
  url "https://github.com/leopard-gecko/homebrew-game/releases/download/v5.4.5.jec.050/rogue_545_jec_050.tar.gz"
  version "5.4.5jec.050"
  sha256 "b72f835b3b434ef6350cd6cc8a1e48d7f92671f84fdc7c78387287fea988a14b"

  option "with-modern-settings", "カラー有効、passgo有効、識別の巻き物1種類、カーソル非表示を初期設定にしてビルドする"
  option "with-japanese", "日本語を初期言語にしてビルドする"
  option "with-english", "英語を初期言語にしてビルドする"
  option "with-wizardmode", "ウィザードモードありでビルドする"

  def install
    odie "--with-japanese and --with-english cannot be used together" if build.with?("japanese") && build.with?("english")

    args = %W[
      --prefix=#{prefix}
      --program=jrogue
    ]

    args << "--modern" if build.with?("modern-settings")
    args << "--wizard" if build.with?("wizardmode")

    if build.with?("japanese")
      args << "--default-language=ja"
    elsif build.with?("english")
      args << "--default-language=en"
    end

    system "./configure", *args
    system "make", "install"

    doc.install "README.txt"
  end

  test do
    system "#{bin}/jrogue", "-s"
  end
end
