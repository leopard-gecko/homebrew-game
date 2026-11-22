class Rogue52 < Formula
  desc "Rogue 5.2 with Japanese/English, color, and modern OS support"
  homepage "https://github.com/leopard-gecko/rogue_5.2_jec"
  url "https://github.com/leopard-gecko/rogue_5.2_jec/releases/download/v004/rogue_5.2_jec-004.tar.gz"
  sha256 "77dda85ac0040b98a15955864890d5dbd5122071956168997bb222c494d2e90c"
  version "5.2.004"

  def install
    args = %W[
      --prefix=#{prefix}
      --program=rogue52
      --docdir=#{share}/doc/rogue52
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/rogue52", "-s"
  end
end
