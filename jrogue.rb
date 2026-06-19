class Jrogue < Formula
  desc "Rogue 5.4.5 with Japanese/English, color, and macOS fixes"
  homepage "https://leopard-gecko.github.io/jrogue/"
  url "https://github.com/leopard-gecko/homebrew-game/releases/download/v5.4.5.jec.050/rogue_545_jec_050.tar.gz"
  version "5.4.5jec.051"
  sha256 "cb338429d10337c108f09059068c84dbe73b913209ddfad4ce82936496e78508"

  def install
    args = %W[
      --prefix=#{prefix}
      --program=jrogue
      --docdir=#{share}/doc/jrogue
      --save-file=rogue.save
      --score-file=rogue.scr
      --lock-file=rogue.lck
      --modern
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/jrogue", "-s"
  end
end
