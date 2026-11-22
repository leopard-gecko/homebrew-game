class Rogue36 < Formula
  desc "Rogue 3.6 with Japanese/English and modern terminal support"
  homepage "https://github.com/leopard-gecko/rogue_3.6_jec"
  url "https://github.com/leopard-gecko/rogue_3.6_jec/releases/download/v004/rogue_3.6_jec-004.tar.gz"
  version "3.6.004"
  sha256 "b2107f2711784e6d17a39a8a0de53bcb475868f28474113cdc6a82e66a132b65"

  def install
    system "./configure", "--prefix=#{prefix}", "--program=rogue36"
    system "make", "install"

    doc.install Dir["README*.md", "rogue_*.txt", "rogue_*.html", "LICENSE*"]
  end

  test do
    system "#{bin}/rogue36", "-s"
  end
end
