class Jrogue < Formula
  desc "Rogue 5.4.5 with Japanese/English, color, and macOS fixes"
  homepage "https://leopard-gecko.github.io/jrogue/"
  url "https://github.com/leopard-gecko/homebrew-game/releases/download/v5.4.5.jec.056/rogue-5.4.5jec.056-src.tar.gz"
  version "5.4.5jec.056"
  sha256 "a163fb5b9d5fc98dec2bfdb04e04bf9182df3ebf82c411e7ce40afe7bc2b046a"

  def install
    args = %W[
      --prefix=#{prefix}
      --program=jrogue
      --docdir=#{share}/doc/jrogue
      --save-file=rogue.save
      --score-file=rogue.scr
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/jrogue", "-s"
  end
end
