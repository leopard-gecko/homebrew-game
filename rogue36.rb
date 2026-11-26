class Rogue36 < Formula
  desc "Rogue 3.6 with Japanese/English and modern terminal support"
  homepage "https://github.com/leopard-gecko/rogue_3.6_jec"
  url "https://github.com/leopard-gecko/rogue_3.6_jec/releases/download/v007/rogue_3.6_jec-007.tar.gz"
  version "3.6.007"
  sha256 "bcd9a34f5f0e812bc9f1c01c683cc08fb1fa57a7d6e6dcc52a247f7a7abef3bf"

  def install
    system "./configure", "--prefix=#{prefix}", "--program=rogue36"
    system "make", "install"

    doc.install Dir["README*.md", "rogue_*.txt", "rogue_*.html", "LICENSE*"]
  end

  test do
    system "#{bin}/rogue36", "-s"
  end
end
