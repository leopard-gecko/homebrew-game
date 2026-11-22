class Rogue36 < Formula
  desc "Rogue 3.6 with Japanese/English and modern terminal support"
  homepage "https://github.com/leopard-gecko/rogue_3.6_jec"
  url "https://github.com/leopard-gecko/rogue_3.6_jec/releases/download/v005/rogue_3.6_jec-005.tar.gz"
  version "3.6.005"
  sha256 "e843adbb115f10d42f2e0cbf4cadfb177f0aa06e19e5419111aaff3300d196a1"

  def install
    system "./configure", "--prefix=#{prefix}", "--program=rogue36"
    system "make", "install"

    doc.install Dir["README*.md", "rogue_*.txt", "rogue_*.html", "LICENSE*"]
  end

  test do
    system "#{bin}/rogue36", "-s"
  end
end
