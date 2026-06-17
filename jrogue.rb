class Jrogue < Formula
  desc "Rogue 5.4.5 with Japanese/English, color, and macOS fixes"
  homepage "https://leopard-gecko.github.io/jrogue/"
  url "https://github.com/leopard-gecko/homebrew-game/releases/download/v5.4.5.jec.050/rogue_545_jec_050.tar.gz"
  version "5.4.5jec.050"
  sha256 "b72f835b3b434ef6350cd6cc8a1e48d7f92671f84fdc7c78387287fea988a14b"

  def install
    args = %W[
      --prefix=#{prefix}
      --program=jrogue
      --docdir=#{share}/doc/jrogue
      --save-file=jrogue.save
      --score-file=jrogue.scr
      --lock-file=jrogue.lck
      --modern
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/jrogue", "-s"
  end
end
