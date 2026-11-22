class Rogue54Wizard < Formula
  desc "Rogue 5.4.5 with wizard mode, color, and macOS fixes"
  homepage "https://leopard-gecko.github.io/jrogue/"
  url "https://github.com/leopard-gecko/rogue_5.4.5_jec/releases/download/v056/rogue_5.4.5_jec-056.tar.gz"
  version "5.4.5jec.056"
  sha256 "eb6b94eaddc41082b96672107b0eedc5702b6de64b7d7674fe2dea7db8541605"

  def install
    args = %W[
      --prefix=#{prefix}
      --program=rogue54-wizard
      --docdir=#{share}/doc/rogue54-wizard
      --save-file=rogue.save
      --score-file=rogue.scr
      --wizard
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/rogue54-wizard", "-s"
  end
end
