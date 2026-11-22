class Rogue54 < Formula
  desc "Rogue 5.4.5 with Japanese/English, color, and macOS fixes"
  homepage "https://leopard-gecko.github.io/jrogue/"
  url "https://github.com/leopard-gecko/rogue_5.4.5_jec/releases/download/v056/rogue_5.4.5_jec-056.tar.gz"
  version "5.4.5jec.056"
  sha256 "eb6b94eaddc41082b96672107b0eedc5702b6de64b7d7674fe2dea7db8541605"

  def install
    args = %W[
      --prefix=#{prefix}
      --program=rogue54
      --docdir=#{share}/doc/rogue54
      --save-file=rogue.save
      --score-file=rogue.scr
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/rogue54", "-s"
  end
end
