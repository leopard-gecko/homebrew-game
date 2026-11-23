class Rogue54 < Formula
  desc "Rogue 5.4.5 with Japanese/English, color, and macOS fixes"
  homepage "https://leopard-gecko.github.io/jrogue/"
  url "https://github.com/leopard-gecko/rogue_5.4.5_jec/releases/download/v57/rogue-5.4.5jec.057-src.tar.gz"
  version "5.4.5jec.057"
  sha256 "d258f38c976f8a72a0323c1e9369d72df8e267a6087d11ce50a8b6fc45667c91"

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
