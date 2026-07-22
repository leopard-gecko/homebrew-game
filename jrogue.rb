class Jrogue < Formula
  desc "Rogue 5.4.5 with Japanese/English, color, and macOS fixes"
  homepage "https://leopard-gecko.github.io/jrogue/"
  url "https://github.com/leopard-gecko/homebrew-game/releases/download/v5.4.5.jec.052/rogue_545_jec_052.tar.gz"
  version "5.4.5jec.052"
  sha256 "341aadaa05eba8695af3e068afe183719caa41d9d5b62ef118d949d3b9a807b7"

  def install
    args = %W[
      --prefix=#{prefix}
      --program=jrogue
      --docdir=#{share}/doc/jrogue
      --save-file=rogue.save
      --score-file=rogue.scr
      --lock-file=rogue.lck
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/jrogue", "-s"
  end
end
