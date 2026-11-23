class Rogue52 < Formula
  desc "Rogue 5.2 with Japanese/English, color, and modern OS support"
  homepage "https://github.com/leopard-gecko/rogue_5.2_jec"
  url "https://github.com/leopard-gecko/rogue_5.2_jec/releases/download/v005/rogue52_005-src.tar.gz"
  sha256 "ba38e97f2cf7a06bee9905aaa7f20bf80ddaf0416ab3a2f4f63c6d240b95afa8"
  version "5.2.005"

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
